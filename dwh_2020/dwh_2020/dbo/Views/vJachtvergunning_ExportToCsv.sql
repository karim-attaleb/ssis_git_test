





------------------------------------------------------------

CREATE view [dbo].[vJachtvergunning_ExportToCsv]

as 

WITH IndieningAttachments (IndieningID, AttachmentDocumentTypeID, FileName)
AS(
	SELECT I.IndieningId, AINFO.AttachmentDocumentTypeID, AINFO.FileName
    FROM [IndieningRegister].[IR].[Indiening] I
		JOIN [IndieningRegister].[IR].[AttachmentSet] ASET ON I.AttachmentSetID = ASET.AttachmentSetID
		JOIN [IndieningRegister].[IR].[AttachmentInfo] AINFO ON ASET.AttachmentSetID = AINFO.AttachmentSetID
),

WorkflowHistory_old (IndieningID, Naam, ToStatus, Date)
AS(
	SELECT WH.EntityID, WH.ActorID, WH.ToWorkflowStatusID, WH.Date 
	FROM [IndieningRegister].[IR].[WorkflowHistory] WH
	WHERE WH.EntityID in (SELECT top 10 J.IndieningID FROM [IndieningRegister].[FF].[JachtVergunning] J)
		AND (WH.ToWorkflowStatusID = 'ACP' OR WH.ToWorkflowStatusID = 'REJ')
),

WorkflowHistory (IndieningID, Naam, ToStatus, Date)
AS(
	SELECT WH.EntityID, WH.ActorID, WH.ToWorkflowStatusID, WH.Date 
	FROM [IndieningRegister].[IR].[WorkflowHistory] WH
	WHERE WH.ToWorkflowStatusID = 'ACP' -- aanvaard
		OR WH.ToWorkflowStatusID = 'REJ' -- verworpen
),

WorkflowHistoryTMP_old (IndieningID, Naam, ToStatus, Date)
AS(
	SELECT WH.EntityID, WH.ActorID, WH.ToWorkflowStatusID, WH.Date 
	FROM [IndieningRegister].[IR].[WorkflowHistory] WH
	WHERE WH.EntityID in (SELECT top 10 J.IndieningID FROM [IndieningRegister].[FF].[JachtVergunning] J)
		AND (WH.ToWorkflowStatusID = 'TMPACP' OR WH.ToWorkflowStatusID = 'TMPREJ')
),

WorkflowHistoryTMP (IndieningID, Naam, ToStatus, Date)
AS(
	SELECT WH.EntityID, WH.ActorID, WH.ToWorkflowStatusID, WH.Date 
	FROM [IndieningRegister].[IR].[WorkflowHistory] WH
	WHERE WH.ToWorkflowStatusID = 'TMPACP'  -- tijdelijk aanvaard
		OR WH.ToWorkflowStatusID = 'TMPREJ' -- tijdelijk verworpen
)


SELECT
  J.IndieningID								AS [ID],
  ITV.IndieningTypeVersieID					AS [Versie],
  I.Jaartal									AS [Jaar],
  I.ProvincieID								AS [Prov ID],
  format(IFF.OndertekeningDatum,'dd/MM/yyyy') 
											AS [Datum Ondertek.],
  format(IFF.OntvangstDatum,'dd/MM/yyyy') 
											AS [Datum Ontvangst],
  format(I.CreateDatum,'dd/MM/yyyy')		AS [Datum Aanmaak],
  format(I.IngediendDatum, 'dd/MM/yyyy')	AS [Datum Indiening],

  S.Description								AS [Status],
  I.DossierNummer							AS [Dossiernr],
  --ITV.Description							AS [IndieningType],
  (SELECT NAT.Description FROM [MasterData].[dbo].[Nationaliteit] NAT WHERE NAT.NationaliteitID = INDR.NationaliteitID)		
											AS [Nat. Aanvrgr],
  RRN.Waarde								AS [Rijksrgnr. Aanvrgr],
  format(INDR.GeboorteDatum,'dd/MM/yyyy') 
											AS [Geb.Datum Aanvrgr],
  INDR.GeslachtID							AS [Geslacht Aanvrgr],
  dbo.CleanString(INDR.Voornaam)			AS [Voorn. Aanvrgr],
  dbo.CleanString(INDR.Naam)				AS [Naam Aanvrgr],
  (SELECT Land.Description FROM [MasterData].[dbo].[Land] LAND WHERE LAND.LandID = RRNPA.LandID) 
											AS [Land Aanvrgr],
  dbo.CleanString(RRNPA.GemeentePostCode)	AS [Postc Aanvrgr],
  dbo.CleanString(RRNPA.GemeenteNaam)		AS [Gemeente Aanvrgr],
  dbo.CleanString(RRNPA.Straatnaam)			AS [Straat Aanvrgr],
  dbo.CleanString(RRNPA.Huisnummer)			AS [Huisnr Aanvrgr],
  dbo.CleanString(RRNPA.Busnummer)			AS [Bus Aanvrgr],
  dbo.CleanString(INDR.TELEFOON)			AS [Telnr Aanvrgr],
  dbo.CleanString(INDR.Email)				AS [E-mail Aanvrgr],
  J.JachtVergunningNummer					AS [Jachtvergunningnr],
  J.JachtVerlofNummerAanvrager				AS [Jachtverlofnr Aanvrgr],

   dbo.CleanString(GNDGD.Voornaam)			AS [Voorn. Genod.],
   dbo.CleanString(GNDGD.Naam)				AS [Naam Genod.],

  (SELECT NAT.Description FROM [MasterData].[dbo].[Nationaliteit] NAT WHERE NAT.NationaliteitID = GNDGD.NationaliteitID) 
											AS [Nat. Genod.],
  RRNGNDGD.Waarde							AS [Rijksrgnr Genod.],
  GNDGD.GeboorteDatum						AS [Geb.Datum Genod.],
  GNDGD.GeslachtID							AS [Geslacht Genod.],
  (SELECT Land.Description FROM [MasterData].[dbo].[Land] LAND WHERE LAND.LandID = RRNGNDGDPA.LandID) 
											AS [Land Genod.],

  dbo.CleanString(RRNGNDGDPA.GemeentePostCode)			AS [Postc. Genod.],
  dbo.CleanString(RRNGNDGDPA.GemeenteNaam)				AS [Gemeente Genod.],
  dbo.CleanString(RRNGNDGDPA.Straatnaam)				AS [Straat Genod.],
  dbo.CleanString(RRNGNDGDPA.Huisnummer)				AS [Huisnr Genod.],
  dbo.CleanString(RRNGNDGDPA.Busnummer)					AS [Bus Genod.],
  dbo.CleanString(GNDGD.TELEFOON)						AS [Telnr Genod.],
  dbo.CleanString(GNDGD.Email)							AS [E-mail Genod.],
  JVT.Bedrag								AS [Type jachtverlof],
  format(J.GeldigheidDatum1,'dd/MM/yyyy')	AS [Dag 1],
  format(J.GeldigheidDatum2,'dd/MM/yyyy')	AS [Dag 2],
  format(J.GeldigheidDatum3,'dd/MM/yyyy')	AS [Dag 3],
  format(J.GeldigheidDatum4,'dd/MM/yyyy')	AS [Dag 4],
  format(J.GeldigheidDatum5,'dd/MM/yyyy')	AS [Dag 5],

  CASE 
    WHEN J.BijlageJachtVerlofGenodigdeFlag = 1 THEN 'Ja'
    ELSE 'Nee'
  END										AS [Kopie buitenl. jachtverlof],
  CASE 
	WHEN ISNULL(IAJaExGenod.[FileName],'') = '' THEN 'Nee' 
	ELSE 'Ja' 
  END										AS [Kopie buitenl. jachtverlof aanwzg],

  CASE 
    WHEN J.BijlageIdentiteitGenodigdeFlag = 1 OR LEN(RRNGNDGD.Waarde) > 0 THEN 'Ja'
    ELSE 'Nee'
  END										AS [Kopie ID-bewijs],
  CASE 
	WHEN ISNULL(IAIDGenodig.[FileName],'') = '' THEN 'Nee' 
	ELSE 'Ja' 
  END										AS [Kopie ID-bewijs aanwzg],

  CASE 
    WHEN J.BijlagePasfotoGenodigdeFlag = 1 THEN 'Ja'
    ELSE 'Nee'
  END										AS [Pasfoto aanwzg],

  (SELECT CAST(UC.Description AS VARCHAR(MAX)) FROM [IndieningRegister].[IR].[UserCode] UC WHERE UC.UserCodeID = J.BetalingTypeID) 
											AS [Betalingswijze],

  CASE j.[BijlageBetalingFlag]						
    WHEN 1 THEN 'Ja'
    WHEN 0 THEN 'Nee'
    ELSE 'Nee'
  END										AS [Bewijs Vl. belast.],
  CASE 
    WHEN LEN(IABEWBET.FileName) > 0 THEN 'Ja'
    ELSE 'Nee'
  END										AS [Bewijs Vl. belast. aanwzg],


  CASE 
    WHEN LEN(IABWBTBL.FileName) > 0 THEN 'Ja'
    ELSE 'Nee'
  END										AS [Bewijs prov. belast. aanwzg],

 
   CASE 
    WHEN LEN(IAPSTSTK.FileName) > 0 OR IFF.OntvangstDatum is not null THEN 'Door administratie'
    ELSE 'Door aanvrager online'
  END										AS [Indieningswijze],
  CASE 
    WHEN LEN(UPDT.Voornaam) > 0 THEN dbo.CleanString(UPDT.Voornaam)
    ELSE dbo.CleanString(CRTB.Voornaam) 
  END										AS [Voorn. ingediend door],
   CASE 
    WHEN LEN(UPDT.Naam) > 0 THEN dbo.CleanString(UPDT.Naam)
    ELSE dbo.CleanString(CRTB.Naam) 
  END										AS [Naam. ingediend door],
 
  CASE 
    WHEN LEN(IAPSTSTK.FileName) > 0 THEN 'Ja'
    ELSE 'Nee'
  END										AS [Papieren dossier aanwzg],
  dbo.CleanString(IFF.Commentaar)			AS [Opmerkingen],
  CASE 
    WHEN LEN(IAEBIJL.FileName) > 0 THEN 'Ja'
    ELSE 'Nee'
  END										AS [Extra bijlage aanwzg ],

  (SELECT TOP 1 dbo.CleanString(NAAM) FROM WorkflowHistoryTMP WH WHERE WH.IndieningID = J.IndieningID ORDER BY WH.Date DESC) 
											AS [Tijdelijk goed-/afgekeurd door],

  (SELECT TOP 1 dbo.CleanString(NAAM) FROM WorkflowHistory WH WHERE WH.IndieningID = J.IndieningID ORDER BY WH.Date DESC) 
											AS [Goed-/afgekeurd door],

   CASE WHEN ROW_NUMBER() OVER (PARTITION BY J.IndieningID ORDER BY J.IndieningID) > 1 Then 'Dubbel' ELSE 'OK' END
											AS [ID Dubbel],
   CASE 
		WHEN 
			ROW_NUMBER() OVER (PARTITION BY J.JachtVergunningNummer ORDER BY J.JachtVergunningNummer) > 1 
			AND J.JachtVergunningNummer IS NOT NULL
			THEN 'Dubbel' 
		ELSE 'OK' 
   END
											AS [Jachtvergunningnr Dubbel]



  FROM  
	[IndieningRegister].[FF].[JachtVergunning] J
	LEFT JOIN [IndieningRegister].[FF].[JachtVergunningType] JVT 
		ON J.JachtVergunningTypeID = JVT.JachtVergunningTypeID
	LEFT JOIN [IndieningRegister].[IR].[Indiening] I 
		ON J.IndieningID = I.IndieningID
	LEFT JOIN [IndieningRegister].[FF].[IndieningFaunaFlora] IFF 
		ON I.IndieningID = IFF.IndieningID
	LEFT JOIN [IndieningRegister].[IR].[IndieningTypeVersie] ITV 
		ON I.IndieningTypeVersieID = ITV.IndieningTypeVersieID
	LEFT JOIN [IndieningRegister].[IR].[IndieningStatus] S 
		ON I.IndieningStatusID = S.IndieningStatusID
	LEFT JOIN [IndieningRegister].[IR].[IndieningPartij] INDR 
		ON I.IndieningID = INDR.IndieningID 
			AND INDR.IndieningPartijTypeID = 'INDR'
	LEFT JOIN [IndieningRegister].[IR].[PartijIdentificatie] RRN 
		ON RRN.IndieningPartijID = INDR.IndieningPartijID 
			AND RRN.PartijIdentificatieTypeID = 'RIJKSRNR'
	LEFT JOIN [IndieningRegister].[IR].[PartijAdres] RRNPA 
		ON INDR.IndieningPartijID = RRNPA.IndieningPartijID 
			AND RRNPA.PartijAdresTypeID = 'THUIS'
	LEFT JOIN [IndieningRegister].[IR].[IndieningPartij] GNDGD 
		ON I.IndieningID = GNDGD.IndieningID 
			AND GNDGD.IndieningPartijTypeID = 'GNDGD'
	LEFT JOIN [IndieningRegister].[IR].[PartijIdentificatie] RRNGNDGD 
		ON RRNGNDGD.IndieningPartijID = GNDGD.IndieningPartijID 
			AND RRNGNDGD.PartijIdentificatieTypeID = 'RIJKSRNR'
	LEFT JOIN [IndieningRegister].[IR].[PartijAdres] RRNGNDGDPA 
		ON GNDGD.IndieningPartijID = RRNGNDGDPA.IndieningPartijID 
			AND RRNGNDGDPA.PartijAdresTypeID = 'THUIS'
	LEFT JOIN [IndieningRegister].[IR].[IndieningPartij] CRTB 
		ON I.IndieningID = CRTB.IndieningID 
			AND CRTB.IndieningPartijTypeID = 'CRTB'
	LEFT JOIN [IndieningRegister].[IR].[IndieningPartij] UPDT 
		ON I.IndieningID = UPDT.IndieningID 
			AND UPDT.IndieningPartijTypeID = 'UPDT'

	LEFT JOIN IndieningAttachments IABEWBET 
		ON IABEWBET.IndieningID = J.IndieningID 
			AND IABEWBET.AttachmentDocumentTypeID = 'BEWBET' --bewijs betaling
	LEFT JOIN IndieningAttachments IABWBTBL 
		ON IABWBTBL.IndieningID = J.IndieningID 
			AND IABWBTBL.AttachmentDocumentTypeID = 'BWBTBL' --bewijs betaling belasting
	LEFT JOIN IndieningAttachments IAPSTSTK 
		ON IAPSTSTK.IndieningID = J.IndieningID 
			AND IAPSTSTK.AttachmentDocumentTypeID = 'PSTSTK'  -- papieren dossier
	LEFT JOIN IndieningAttachments IAEBIJL 
		ON IAEBIJL.IndieningID = J.IndieningID 
			AND IAEBIJL.AttachmentDocumentTypeID = 'EBIJL'   --extra bijlage

	LEFT JOIN IndieningAttachments IAStrafreg 
		ON IAStrafreg.IndieningID = J.IndieningID 
			AND IAStrafreg.AttachmentDocumentTypeID = 'UTRSTRG' -- uittreksel strafreg.

	LEFT JOIN IndieningAttachments IAMedAtt 
		ON IAMedAtt.IndieningID = J.IndieningID 
			AND IAMedAtt.AttachmentDocumentTypeID = 'MEDATTST' -- medisch attest

	LEFT JOIN IndieningAttachments IAJaExGenod 
		ON IAJaExGenod.IndieningID = J.IndieningID 
			AND IAJaExGenod.AttachmentDocumentTypeID = 'JVGNDGD' -- jachtexamen genodgde

	LEFT JOIN IndieningAttachments IAIDGenodig 
		ON IAIDGenodig.IndieningID = J.IndieningID 
			AND IAIDGenodig.AttachmentDocumentTypeID = 'IDGNDGD' -- Indentiteit genodigde

  WHERE 
	J.SoftDeleted = 0
	and I.SnapshotIndieningID is null
	AND S.Description <> 'Geannuleerd'

-------------------------------------------------------------------


;