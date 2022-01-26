
---------------------------------------------------------

CREATE view [dbo].[vVisverlof]

as 

/*
WITH 

IndieningAttachments (IndieningID, AttachmentDocumentTypeID, FileName)
AS(
	SELECT I.IndieningId, AINFO.AttachmentDocumentTypeID, AINFO.FileName
    FROM [IndieningRegister].[IR].[Indiening] I
	JOIN [IndieningRegister].[IR].[AttachmentSet] ASET ON I.AttachmentSetID = ASET.AttachmentSetID
	JOIN [IndieningRegister].[IR].[AttachmentInfo] AINFO ON ASET.AttachmentSetID = AINFO.AttachmentSetID
)
*/
----------------------------------

SELECT
  V.IndieningID									AS [ID],
  --ITV.versie,
  --ITV.IndieningTypeVersieID						AS [Versie2],
  I.Jaartal										AS [Jaar],
  I.ProvincieID 								AS [Provincie ID],
  format(IFF.OndertekeningDatum,'dd/MM/yyyy')	AS [Datum Ondertekening],
  format(IFF.OntvangstDatum,'dd/MM/yyyy')		AS [Datum Ontvangst],
  format(I.CreateDatum,'dd/MM/yyyy')			AS [Datum Aanmaak],
  format(I.IngediendDatum, 'dd/MM/yyyy')		AS [Datum Indiening],
  
  S.Description									AS [Status],
  I.DossierNummer								AS [Dossier Nr],
  CASE WHEN V.OorsprongTypeID IS NULL THEN '_Onbekend' ELSE V.OorsprongTypeID END
												AS [Oorsprong],

  --replace(replace(itv.Description, CHAR(13)+CHAR(10), ', '), ';', '-') 
  --												AS [Indiening Type],

  (SELECT NAT.Description FROM [MasterData].[dbo].[Nationaliteit] NAT WHERE NAT.NationaliteitID = INDR.NationaliteitID) 
												AS [Nationaliteit],
  RRN.Waarde									AS [Rijksreg. Nr],
  format(INDR.GeboorteDatum,'dd/MM/yyyy')		AS [GeboorteDatum],
  INDR.GeslachtID								AS [Geslacht],
  INDR.Voornaam									AS [Voornaam],
  INDR.Naam										AS [Naam],
  (SELECT PROV.LandID FROM [MasterData].[dbo].[Provincie] PROV WHERE PROV.ProvincieID = I.ProvincieID) 
												AS [Land],
  RRNPA.GemeentePostCode						AS [Postcode],
  RRNPA.GemeenteNaam							AS [Gemeente],
  RRNPA.Straatnaam								AS [Straat],
  RRNPA.Huisnummer								AS [Huis Nr],
  RRNPA.Busnummer								AS [Bus],
  INDR.TELEFOON									AS [Tel Nr],
  INDR.Email									AS [E-mail],
  --V.VisVerlofNummer								AS [Visverlof Nr],

  CASE WHEN v.VisVerlofEigen = 1 THEN 'Zichzelf' ELSE 'Kind' END
												AS [Aangevraagd Voor],								

 (SELECT NAT.Description FROM [MasterData].[dbo].[Nationaliteit] NAT WHERE NAT.NationaliteitID = GNDGD.NationaliteitID) 
												AS [Nationaliteit Kind],
 format(GNDGD.GeboorteDatum,'dd/MM/yyyy')		AS [GeboorteDatum Kind],
 GNDGD.voornaam									AS [Voornaam Kind],
 GNDGD.naam										AS [Naam Kind],
 GNDGDPA.LandID									AS [Land Kind],
 GNDGDPA.GemeentePostCode						AS [Postcode Kind],
 GNDGDPA.GemeenteNaam							AS [Gemeente Kind],
 GNDGDPA.Straatnaam								AS [Straat Kind],
 GNDGDPA.Huisnummer								AS [Huis Nr Kind],
 GNDGDPA.Busnummer								AS [Bus Kind],
 GNDGD.TELEFOON									AS [Tel Nr Kind],
 GNDGD.Email									AS [E-mail Kind],

 (SELECT JVT.Description FROM [IndieningRegister].[FF].[VisVerlofType] JVT WHERE JVT.VisVerlofTypeID = V.VisVerlofTypeID) 
												AS [Type Visverlof],
  v.bedrag,
   CASE 
    WHEN IFF.OntvangstDatum is not null THEN 'Door administratie'
    ELSE 'Door aanvrager online'
  END											AS [Indieningswijze],

  v.ReglementTaal								AS [Taal Reglement],
  CASE WHEN v.InfoBrochure= 1 THEN 'Ja' ELSE 'Nee' END
												AS [Infobrochure Gewenst],

  CRTB.Voornaam									AS [Voornaam ingediend door],
  CRTB.Naam										AS [Achternaam ingediend door]
  
  
FROM 
  [IndieningRegister].[FF].[VisVerlof] V
  
  LEFT JOIN [IndieningRegister].[IR].[Indiening] I 
	ON V.IndieningID = I.IndieningID
  LEFT JOIN [IndieningRegister].[FF].[IndieningFaunaFlora] IFF 
	ON I.IndieningID = IFF.IndieningID

  LEFT JOIN [IndieningRegister].[IR].[IndieningTypeVersie] ITV 
	ON I.IndieningTypeVersieID = ITV.IndieningTypeVersieID
  LEFT JOIN [IndieningRegister].[IR].[IndieningStatus] S 
	ON I.IndieningStatusID = S.IndieningStatusID

  LEFT JOIN [IndieningRegister].[IR].[IndieningPartij] INDR -- indiener of aanvrager
	ON I.IndieningID = INDR.IndieningID 
		AND INDR.IndieningPartijTypeID = 'INDR' 

  LEFT JOIN [IndieningRegister].[IR].[PartijIdentificatie] RRN 
	ON RRN.IndieningPartijID = INDR.IndieningPartijID 
		AND RRN.PartijIdentificatieTypeID = 'RIJKSRNR'

  LEFT JOIN [IndieningRegister].[IR].[PartijAdres] RRNPA 
	ON INDR.IndieningPartijID = RRNPA.IndieningPartijID 
		AND RRNPA.PartijAdresTypeID = 'THUIS'

  LEFT JOIN [IndieningRegister].[IR].[IndieningPartij] CRTB --ingever
	ON I.IndieningID = CRTB.IndieningID 
		AND CRTB.IndieningPartijTypeID = 'CRTB' 

   LEFT JOIN [IndieningRegister].[IR].[IndieningPartij] GNDGD -- genodigde (kind)
	ON I.IndieningID = GNDGD.IndieningID 
		AND GNDGD.IndieningPartijTypeID = 'GNDGD' 

   LEFT JOIN [IndieningRegister].[IR].[PartijAdres] GNDGDPA --genodigde partij adres (kind)
	ON GNDGD.IndieningPartijID = GNDGDPA.IndieningPartijID 
		AND GNDGDPA.PartijAdresTypeID = 'THUIS'
  

  /*
	LEFT JOIN [IndieningRegister].[IR].[PartijIdentificatie] RRNGNDGD 
		ON RRNGNDGD.IndieningPartijID = GNDGD.IndieningPartijID 
			AND RRNGNDGD.PartijIdentificatieTypeID = 'RIJKSRNR'

	LEFT JOIN [IndieningRegister].[IR].[PartijAdres] RRNGNDGDPA 
		ON GNDGD.IndieningPartijID = RRNGNDGDPA.IndieningPartijID 
*/



WHERE V.SoftDeleted = 0
      AND I.SnapshotIndieningID is null

	  --AND I.IndieningID = 8585
	  --AND  V.[BijlageBetalingFlag] = 
	  --AND v.IndieningID = 209343

--order by
--	v.IndieningID desc
;