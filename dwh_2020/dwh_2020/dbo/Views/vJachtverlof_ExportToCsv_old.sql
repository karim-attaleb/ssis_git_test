


---------------------------------------------------------

CREATE view [dbo].[vJachtverlof_ExportToCsv_old]

as 

WITH LaatsteIndieningJachtExamenTheoretisch (IndieningId, RRN, Jaartal, Dossiernummer)  
AS  
(  
    SELECT I.IndieningId, RRN.Waarde, I.Jaartal, I.DossierNummer
    FROM [IndieningRegister].[IR].[Indiening] I
	JOIN [IndieningRegister].[IR].[IndieningTypeVersie] ITV ON I.IndieningTypeVersieID = ITV.IndieningTypeVersieID
	JOIN [IndieningRegister].[FF].[Examen] E ON E.IndieningID = I.IndieningID
	JOIN [IndieningRegister].[IR].[IndieningPartij] INDR ON I.IndieningID = INDR.IndieningID AND INDR.IndieningPartijTypeID = 'INDR'
    JOIN [IndieningRegister].[IR].[PartijIdentificatie] RRN ON RRN.IndieningPartijID = INDR.IndieningPartijID AND RRN.PartijIdentificatieTypeID = 'RIJKSRNR'
	WHERE ITV.IndieningTypeID = 'JHTEXATEO' AND E.SoftDeleted = 0 AND (E.Geslaagd = 1 OR E.GeslaagdNaDeliberatie = 1)
),

LaatsteIndieningJachtExamenPraktisch (IndieningId, RRN, Jaartal, Dossiernummer)  
AS  
(  
    SELECT I.IndieningId, RRN.Waarde, I.Jaartal, I.DossierNummer
    FROM [IndieningRegister].[IR].[Indiening] I
	JOIN [IndieningRegister].[IR].[IndieningTypeVersie] ITV ON I.IndieningTypeVersieID = ITV.IndieningTypeVersieID
	JOIN [IndieningRegister].[FF].[Examen] E ON E.IndieningID = I.IndieningID
	JOIN [IndieningRegister].[IR].[IndieningPartij] INDR ON I.IndieningID = INDR.IndieningID AND INDR.IndieningPartijTypeID = 'INDR'
    JOIN [IndieningRegister].[IR].[PartijIdentificatie] RRN ON RRN.IndieningPartijID = INDR.IndieningPartijID AND RRN.PartijIdentificatieTypeID = 'RIJKSRNR'
	WHERE ITV.IndieningTypeID = 'JHTEXAPRK' AND E.SoftDeleted = 0 AND (E.Geslaagd = 1 OR E.GeslaagdNaDeliberatie = 1)
),

IndieningAttachments (IndieningID, AttachmentDocumentTypeID, FileName)
AS(
	SELECT I.IndieningId, AINFO.AttachmentDocumentTypeID, AINFO.FileName
    FROM [IndieningRegister].[IR].[Indiening] I
	JOIN [IndieningRegister].[IR].[AttachmentSet] ASET ON I.AttachmentSetID = ASET.AttachmentSetID
	JOIN [IndieningRegister].[IR].[AttachmentInfo] AINFO ON ASET.AttachmentSetID = AINFO.AttachmentSetID
),

WorkflowHistory (IndieningID, Naam, ToStatus, Date)
AS(
	SELECT WH.EntityID, WH.ActorID, WH.ToWorkflowStatusID, WH.Date FROM [IndieningRegister].[IR].[WorkflowHistory] WH
	WHERE WH.EntityID in (SELECT J.IndieningID FROM [IndieningRegister].[FF].[JachtVerlof] J)
		AND (WH.ToWorkflowStatusID = 'ACP' OR WH.ToWorkflowStatusID = 'REJ')
),

WorkflowHistoryTMP (IndieningID, Naam, ToStatus, Date)
AS(
	SELECT WH.EntityID, WH.ActorID, WH.ToWorkflowStatusID, WH.Date FROM [IndieningRegister].[IR].[WorkflowHistory] WH
	WHERE WH.EntityID in (SELECT J.IndieningID FROM [IndieningRegister].[FF].[JachtVerlof] J)
		AND (WH.ToWorkflowStatusID = 'TMPACP' OR WH.ToWorkflowStatusID = 'TMPREJ')
)

----------------------------------

SELECT top 10
  J.IndieningID									AS [ID],
  ITV.IndieningTypeVersieID						AS [Versie],
  I.Jaartal										AS [Jaar],
  I.ProvincieID 								AS [Provincie ID],
  format(IFF.OndertekeningDatum,'dd/MM/yyyy')	AS [Datum Ondertekening],
  format(IFF.OntvangstDatum,'dd/MM/yyyy')		AS [Datum Ontvangst],
  format(I.CreateDatum,'dd/MM/yyyy')			AS [Datum Aanmaak],
  format(I.IngediendDatum, 'dd/MM/yyyy')		AS [Datum Indiening],

  S.Description									AS [Status],
  I.DossierNummer								AS [Dossier Nr],
  --dbo.CleanString(itv.Description)			AS [Indiening Type],
  (SELECT NAT.Description FROM [MasterData].[dbo].[Nationaliteit] NAT WHERE NAT.NationaliteitID = INDR.NationaliteitID) 
												AS [Nationaliteit],
  RRN.Waarde									AS [Rijksreg. Nr],
  format(INDR.GeboorteDatum,'dd/MM/yyyy')		AS [GeboorteDatum],
  INDR.GeslachtID								AS [Geslacht],
  dbo.CleanString(INDR.Voornaam)				AS [Voornaam],
  dbo.CleanString(INDR.Naam)					AS [Naam],
  (SELECT PROV.LandID FROM [MasterData].[dbo].[Provincie] PROV WHERE PROV.ProvincieID = I.ProvincieID) 
												AS [Land],
  dbo.CleanString(RRNPA.GemeentePostCode)		AS [Postcode],
  dbo.CleanString(RRNPA.GemeenteNaam)			AS [Gemeente],
  dbo.CleanString(RRNPA.Straatnaam)				AS [Straat],
  dbo.CleanString(RRNPA.Huisnummer)				AS [Huis Nr],
  dbo.CleanString(RRNPA.Busnummer)				AS [Bus],
  dbo.CleanString(INDR.TELEFOON)				AS [Tel Nr],
  dbo.CleanString(INDR.Email)					AS [E-mail],
  J.JachtVerlofNummer							AS [Jachtverlof Nr],
 (SELECT JVT.Bedrag FROM [IndieningRegister].[FF].[JachtVerlofType] JVT WHERE JVT.JachtVerlofTypeID = J.JachtVerlofTypeID) 
												AS [Type jachtverlof],
  CASE J.BijlageStrafregisterFlag
    WHEN 1 THEN 'Ja'
    WHEN 0 THEN 'Nee'
    ELSE 'Nee'
  END											AS [Uittreksel strafregister],
  CASE 
	WHEN ISNULL(IAStrafreg.[FileName],'') = '' THEN 'Nee' 
	ELSE 'Ja' 
  END											AS [Uittreksel strafregister aanwezig],

  CASE J.BijlageJachtexamenFlag
    WHEN 1 THEN 'Ja'
    WHEN 0 THEN 'Nee'
    ELSE 'Nee'
  END											AS [Uittreksel jachtexamen],
  CASE 
	WHEN ISNULL(IAJachtEx.[FileName],'') = '' THEN 'Nee' 
	ELSE 'Ja' 
  END											AS [Uittreksel jachtexamen aanwezig],

  CASE J.BijlageMedischAttestFlag
    WHEN 1 THEN 'Ja'
    WHEN 0 THEN 'Nee'
    ELSE 'Nee'
  END											AS [Medisch attest],
  CASE 
	WHEN ISNULL(IAMedAtt.[FileName],'') = '' THEN 'Nee' 
	ELSE 'Ja' 
  END											AS [Medisch attest aanwezig],


  J.VorigJachtVerlofNummer						AS [Jachtverlof Nr vorig jachtseizoen],
  (SELECT UC.Description FROM [IndieningRegister].[IR].[UserCode] UC WHERE UC.UserCodeID = J.BetalingTypeID) 
												AS [Betalingswijze],

  CASE j.[BijlageBetalingFlag]						
    WHEN 1 THEN 'Ja'
    WHEN 0 THEN 'Nee'
    ELSE 'Nee'
  END											AS [Bewijs Vlaamse belasting],
  CASE 
    WHEN LEN(IABEWBET.FileName) > 0 THEN 'Ja'
    ELSE 'Nee'
  END											AS [Bewijs Vlaamse belasting aanwezig],

  CASE 
    WHEN LEN(IABWBTBL.FileName) > 0 THEN 'Ja'
    ELSE 'Nee'
  END											AS [Bewijs provinciebelasting aanwezig],

  LIJET.IndieningID								AS [IndieningID theoretisch examen],
  LIJET.Dossiernummer							AS [DossierNr theoretisch examen],
  LIJET.Jaartal									AS [Jaar theoretisch examen],
  LIJEP.IndieningID								AS [IndieningID praktisch examen],
  LIJEP.Dossiernummer							AS [DossierNr praktisch examen],
  LIJEP.Jaartal									AS [Jaar praktisch examen],
  J.VorigJachtVerlofNummer						AS [Laatste vorig jachtverlofNr],
  (SELECT TOP 1 I.Jaartal FROM [IndieningRegister].[IR].[Indiening] I WHERE I.DossierNummer = J.VorigJachtVerlofNummer ORDER BY I.IndieningID DESC) 
												AS [Jaar laatste vorig jachtverlof],
  
   CASE 
    WHEN LEN(IAPSTSTK.FileName) > 0 OR IFF.OntvangstDatum is not null THEN 'Door administratie'
    ELSE 'Door aanvrager online'
  END											AS [Indieningswijze],
  dbo.CleanString(CRTB.Voornaam)				AS [Voornaam ingediend door],
  dbo.CleanString(CRTB.Naam)					AS [Achternaam ingediend door],
  
  CASE 
    WHEN LEN(IAPSTSTK.FileName) > 0 THEN 'Ja'
    ELSE 'Nee'
  END											AS [Papieren dossier aanwezig],

  dbo.CleanString(IFFH.Commentaar)				AS [Opmerkingen Vorig Jachtverlof],

  dbo.CleanString(IFF.Commentaar)				AS [Opmerkingen],

  CASE 
    WHEN LEN(IAEBIJL.FileName) > 0 THEN 'Ja'
    ELSE 'Nee'
  END											AS [Extra bijlage aanwezig],

  (SELECT TOP 1 dbo.CleanString(NAAM) FROM WorkflowHistory WH WHERE WH.IndieningID = J.IndieningID ORDER BY WH.Date DESC) 
												AS [Goedgekeurd/afgekeurd door],
  (SELECT TOP 1 dbo.CleanString(NAAM) FROM WorkflowHistoryTMP WH WHERE WH.IndieningID = J.IndieningID ORDER BY WH.Date DESC) 
												AS [Tijdelijk goedgekeurd/afgekeurd door]
  
   --s.Comment		-- geen zinvolle data
   --I.Beschrijving -- geen zinvolle data
   --s.Comment		-- geen zinvolle data
   --IT.Comment,
   --IT.Description
  
FROM 
  [IndieningRegister].[FF].[JachtVerlof] J
  
  LEFT JOIN [IndieningRegister].[IR].[Indiening] I 
	ON J.IndieningID = I.IndieningID
  LEFT JOIN [IndieningRegister].[FF].[IndieningFaunaFlora] IFF 
	ON I.IndieningID = IFF.IndieningID

  --LEFT JOIN [IndieningRegister].[FF].[JachtVerlofHistoriek] JH --Jachtverlof Historiek (vorig)
  --	ON J.VorigJachtVerlofNummer = JH.JachtVerlofNummer
  --		AND JH.Jaartal = YEAR(CURRENT_TIMESTAMP) -1

  LEFT JOIN  [IndieningRegister].[FF].[IndieningFaunaFlora] IFFH  --Indiening Historiek (vorig)
	ON J.VorigJachtVerlofIndieningID = IFFH.IndieningID

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
  LEFT JOIN [IndieningRegister].[IR].[IndieningPartij] CRTB 
	ON I.IndieningID = CRTB.IndieningID 
		AND CRTB.IndieningPartijTypeID = 'CRTB'

  LEFT JOIN IndieningAttachments IAPSTSTK 
	ON IAPSTSTK.IndieningID = J.IndieningID 
		AND IAPSTSTK.AttachmentDocumentTypeID = 'PSTSTK' -- papieren dossier
  LEFT JOIN IndieningAttachments IAEBIJL 
	ON IAEBIJL.IndieningID = J.IndieningID 
		AND IAEBIJL.AttachmentDocumentTypeID = 'EBIJL' -- extra bijlage
  LEFT JOIN IndieningAttachments IABEWBET 
	ON IABEWBET.IndieningID = J.IndieningID 
		AND IABEWBET.AttachmentDocumentTypeID = 'BEWBET' -- bewijs betaling
  LEFT JOIN IndieningAttachments IABWBTBL 
	ON IABWBTBL.IndieningID = J.IndieningID 
		AND IABWBTBL.AttachmentDocumentTypeID = 'BWBTBL' -- bewijs betaling belasting

  LEFT JOIN IndieningAttachments IAStrafreg 
	ON IAStrafreg.IndieningID = J.IndieningID 
		AND IAStrafreg.AttachmentDocumentTypeID = 'UTRSTRG' -- uittreksel strafreg.

  LEFT JOIN IndieningAttachments IAJachtEx 
	ON IAJachtEx.IndieningID = J.IndieningID 
		AND IAJachtEx.AttachmentDocumentTypeID = 'GTJHTEX' -- getuigschrift jachtexamen

  LEFT JOIN IndieningAttachments IAMedAtt 
	ON IAMedAtt.IndieningID = J.IndieningID 
		AND IAMedAtt.AttachmentDocumentTypeID = 'MEDATTST' -- medisch attest

  LEFT JOIN LaatsteIndieningJachtExamenTheoretisch LIJET 
	ON LIJET.RRN = RRN.Waarde
  LEFT JOIN LaatsteIndieningJachtExamenPraktisch LIJEP 
	ON LIJEP.RRN = RRN.Waarde

  --LEFT JOIN IR.IndieningType IT
	--ON IT.IndieningTypeID = ITV.IndieningTypeID

WHERE J.SoftDeleted = 0
      AND I.SnapshotIndieningID is null

	  --AND I.IndieningID = 8585
	  --AND  j.[BijlageBetalingFlag] = 
;

-------------------------------------------------------------------------------------------



/*
CREATE FUNCTION [dbo].[CleanString](@inputString VARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS

BEGIN
	DECLARE @badStrings VARCHAR(256);
	DECLARE @increment INT= 1;
	WHILE @increment <= DATALENGTH(@inputString)
	BEGIN

		-- Vervang CR en LF door ', '
		SET @inputString = replace(@inputString, CHAR(13)+CHAR(10), ', ')

		-- Delete alle speciale characters zoals CR, LF, TAB, DEL, Backspace, ESC, ...
		IF (ASCII(SUBSTRING(@inputString, @increment, 1)) between 0 and 31
			OR ASCII(SUBSTRING(@inputString, @increment, 1)) = 127
		   )
		BEGIN
			SET @badStrings = CHAR(ASCII(SUBSTRING(@inputString, @increment, 1)));
			SET @inputString = REPLACE(@inputString, @badStrings, '');
			SET @increment=@increment-1; 
		END;
		SET @increment = @increment + 1;
	END;

	-- ";" is list separator in BE in CSV files, dus vervang ";" door "-"
	SET @inputString = REPLACE(@inputString, ';', '-')

	RETURN @inputString;

END;
GO
*/