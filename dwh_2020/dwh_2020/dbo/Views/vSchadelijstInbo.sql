
create view [dbo].[vSchadelijstInbo]
as
SELECT  I.[IndieningID]
      , I.[IndieningTypeVersieID]
	  , I.[IndieningStatusID]
	  , I.[AttachmentSetID] 
	  , I.[Jaartal] 
	  , I.[DossierNummer] -- DossierNummer ???
	  , I.[CreateDatum]
	  , I.[UpdateDatum]
	  , I.[IngediendDatum]
	  , I.[BeslissingDatum]
	  , I.[VersieNummer]
	  , I.[SnapshotIndieningID]
	  , I.[VersieDatum]
	  , I.[SnapshotDatum] 
	  , I.[SoftDeleted] AS IndieningSoftDeleted
	  , T.[Description] AS IndieningType
	  , T.[SoftDeleted] AS IndieningTypeSoftDeleted
	  , S.[IndieningSchadeID]    -- Geen relaties tussen IndieningRegister en IndieningSchade gevonden voor onderhavige IndieningID's
	  , CAST(D.[beschrijvingschade] AS NVARCHAR(200)) Beschrijving
	  , CAST(D.[schadetype] AS NVARCHAR(20)) IndieningSchadeBasisCode  --DIepteSchadeTypes, IndieningSchadeCode
	  , CAST(U1.[description] AS NVARCHAR(200)) SchadeBeschrijving -- SchadeTypeCodeHier ,SchadeOmschrijvingHier
	  , D.[typeongeval_aantaldodelijke] AS AantalDodelijke
	  , D.[typeongeval_aantallichamelijke] AS AantalLichamelijke
	  , D.[typeongeval_haslichamelijkeletsels] AS LichameljkeLetsels
      , G.[IndieningLocatieID]
	  , G.[LocatieTypeID] 
	  , K.[Description] AS LocatieTypeCode
	  , K.[SoftDeleted] AS LocatieTypeSoftDeleted
	  , P.[SHAPE] AS  PuntLocatieShape
	  , CAST(P.[SHAPE] AS NVARCHAR(max))  PuntLocatieWKT
	  , Y.[SHAPE] AS  PolyLocatieShape
	  , CAST(Y.[SHAPE] AS  NVARCHAR(max)) PolyLocatieWKT
	  , L.[SHAPE] AS  LijnLocatieShape
	  , CAST(L.[SHAPE] AS  NVARCHAR(max)) LijnLocatieWKT 
	  , COALESCE(Y.[SHAPE], P.[SHape], L.[SHAPE]) LocatieShape
	  , CAST(COALESCE(Y.[SHAPE], P.[SHape], L.[SHAPE]) AS NVARCHAR(max)) LocatieWKT
	  , CAST(D.[plantsoort] AS INT)  PlantSoortId
	  , CAST(U2.[description]  AS NVARCHAR(20)) SoortNaam
	  , CAST(D.[diersoorten_type]  AS NVARCHAR(10)) DierSoortId
	  , CAST(F.[Description] AS NVARCHAR(20)) DierSoortNaam
	  , CAST(D.[schadebedragid] AS NVARCHAR(20)) SchadeBedragId
	  , CAST(U2.[description] AS NVARCHAR(100)) SchadeBedragOmschrijving
	  , CAST(D.[datumveroorzaakt] AS DATETIMEOFFSET) DatumVeroorzaakt
	  , CAST(D.[datumvaststelling] AS DATETIMEOFFSET) DatumVaststelling
	  , CAST(D.[beschrijvingschade] AS NVARCHAR(200)) SchadeRegistratieBeschrijving --Commentaar, SchadeReportSoftDeleted
--INTO [IndieningRegister].[dbo].[SchadeLijstInbo]
FROM [IndieningRegister].[IR].[Indiening] I
   JOIN  [SchadeDossier].[dbo].[schadedossier] D on I.[IndieningGUID] = D.[schadedossier_sk]
   JOIN [IndieningRegister].[GIS].[IndieningLocatie] G ON I.[IndieningID] = G.[IndieningID] AND G.[SoftDeleted] = 0
   JOIN [IndieningRegister].[IR].[IndieningType] T ON I.[IndieningTypeVersieID] = T.[IndieningTypeID] AND T.[IndieningTypeID] = 'SCHM'
   JOIN [IndieningRegister].[GIS].[IndieningLocatieType] K ON K.[IndieningLocatieTypeID] = G.[IndieningLocatieTypeID]
   LEFT JOIN [IndieningRegister].[FF].[IndieningSchade] S ON I.[IndieningID] = S.[IndieningID]
   LEFT JOIN [IndieningRegister].[GIS].[LocatieGeometriePunt] P ON P.[IndieningLocatieID] = G.[IndieningLocatieID]
   LEFT JOIN [IndieningRegister].[GIS].[LocatieGeometriePoly] Y on G.[IndieningLocatieID] = Y.[IndieningLocatieID]
   LEFT JOIN [IndieningRegister].[FF].[Diersoort] F ON CAST(F.[DiersoortID] AS NVARCHAR(20)) COLLATE SQL_Latin1_General_CP1_CI_AS = D.[diersoorten_type]
   LEFT JOIN [IndieningRegister].[GIS].[LocatieGeometrieLijn] L ON G.[IndieningLocatieID] = L.[IndieningLocatieID]
   LEFT JOIN [IndieningRegister].[FF].[SchadeRegistratie] R ON I.[IndieningID] = R.[IndieningID]
   LEFT JOIN [SchadeDossier].[dbo].[usercode] U1 on U1.[schadevergoedingschadetype_sk] =  D.[diersoorten_sk] AND U1.[field] = 'SCHDRGSTR'
   LEFT JOIN [SchadeDossier].[dbo].[usercode] U2 on U2.[schadevergoedingschadetype_sk] =  D.[diersoorten_sk] AND U2.[field] = 'SCHBEDRAG'
 -- ORDER BY I.[IndieningID] 