

CREATE VIEW [dbo].[vMeldingBestrijding_old]
AS 


WITH 
IndieningAttachments (IndieningID, AttachmentDocumentTypeID, FileName) AS(
	SELECT 
		I.IndieningId, 
		AINFO.AttachmentDocumentTypeID, 
		AINFO.FileName
    FROM 
		IR.Indiening I
		JOIN IR.AttachmentSet ASET 
			ON I.AttachmentSetID = ASET.AttachmentSetID
		JOIN IR.AttachmentInfo AINFO 
			ON ASET.AttachmentSetID = AINFO.AttachmentSetID
),
JachtVerlof AS (
	SELECT
		jvf.JachtVerlofNummer,
		jvf.VolgNummerAanvrager,
		vnr.RijksregisterNummer,
		LEFT(jvf.JachtVerlofNummer,4) AS periode
	FROM
		ff.Jachtverlof jvf
		LEFT JOIN ff.JachtVerlofVolgNummer vnr
			ON jvf.VolgNummerAanvrager = vnr.VolgNummer
	WHERE
		LEFT(jvf.JachtVerlofNummer,4) is not null
),
JV_LaatstePeriode AS (
	SELECT 
		Rijksregisternummer,
		max(periode) AS Laatste_periode
	FROM
		JachtVerlof
	GROUP BY 
		RijksregisterNummer
),
LaatsteJachtVerlof AS (
	SELECT DISTINCT
		JachtVerlof.JachtVerlofNummer,
		JachtVerlof.RijksregisterNummer
	FROM	
		JachtVerlof
		INNER JOIN JV_LaatstePeriode
			ON JV_LaatstePeriode.RijksregisterNummer = JachtVerlof.RijksregisterNummer
				AND JV_LaatstePeriode.Laatste_periode = JachtVerlof.periode
)

SELECT		
	   i.IndieningID				as [ID]
	  ,i.VersieNummer				as [Versienr]
	  ,i.jaartal					as [Jaar]
	  ,FORMAT(i.VersieDatum,'dd/MM/yyyy')				
									as [Datum Versie]
	  ,FORMAT(ff.[OndertekeningDatum],'dd/MM/yyyy')		
									as [Datum Ondertekening]
	  ,CASE 
		WHEN ff.[IngediendDoorANB] <> 1 THEN FORMAT(i.[CreateDatum],'dd/MM/yyyy')
		ELSE	FORMAT(ff.[OntvangstDatum],'dd/MM/yyyy')			
	   END							as [Datum Ontvangst]

	  ,FORMAT(i.[CreateDatum],'dd/MM/yyyy')			
									as [Datum Aanmaak]
	  ,FORMAT(i.IngediendDatum,'dd/MM/yyyy')				
									as [Datum Ingediend]
	  ,s.Description				as [Status]
	  --,i.IndieningTypeVersieID		as [Indiening Type Versie ID]
	  ,i.DossierNummer				as [Dossiernr]

	  ,ipi.Voornaam					as [Indiener Voorn.]
	  ,ipi.Naam						as [Indiener Naam]
	  --,ipi.NationaliteitID			as [Indiener Nation. ID]
	  ,(SELECT NAT.Description FROM [MasterData].[dbo].[Nationaliteit] NAT WHERE NAT.NationaliteitID = ipi.NationaliteitID) 
									as [Indiener Nation.]
	  ,FORMAT(ipi.Geboortedatum,'dd/MM/yyyy')				
									as [Indiener Geb. Datum]
	  ,ipi.GeslachtID				as [Indiener Geslacht]
	  ,ipi.Telefoon					as [Indiener Tel]
	  ,ipi.Email					as [Indiener E-mail]
	  ,pai.GemeenteNaam				as [Indiener Gemeente]
	  ,pai.GemeentePostCode			as [Indiener Postcode]
	  ,pai.Straatnaam				as [Indiener Straat]
	  ,pai.Huisnummer				as [Indiener Huisnr]
	  --,pai.LandID					as [Indiener LandID]
	  ,(SELECT LND.Description FROM [MasterData].[dbo].[Land] LND WHERE LND.LandID = pai.LandID) 
									as [Indiener Land]

	  ,UPPER(ds.Description)		as [Bestrijding Diersoort]
	  ,ist.Description				as [Bestrijding Cat.]
	  ,itbs.Commentaar				as [Bestrijding Beschr.]

	  ,mb.VerwachteSchadeID						as [Verwachte Schade Cat.]
	  ,mb.VerwachteSchadeToelichting			as [Verwachte Schade Toel.]

	  ,loc.Beschrijving							as [Kadastraal Perceelnr]
	  ,ba.Description							as [Preventieve Genomen Maatreg.]

	  ,mb.MeldingBestrijdingDatumTypeID			as [Bestrijding Datum Type]
	  ,FORMAT(mb.DatumPeriodeVan,'dd/MM/yyyy')	as [Periode Bestrijding Van]
	  ,FORMAT(mb.DatumPeriodeTot,'dd/MM/yyyy')	as [Periode Bestrijding Tot]
	  ,FORMAT(mbd.Datum,'dd/MM/yyyy')			as [Datum Bestrijding]
	
	  ,ipb.Voornaam					as [Bestrijder Voorn.]
	  ,ipb.Naam						as [Bestrijder Naam]
	  ,ipb.Telefoon					as [Bestrijder Tel]
	  ,ipb.Email					as [Bestrijder E-mail]
	  ,ljv.JachtVerlofNummer		as [Bestrijder Jachtverlofnr]
	
	  ,CASE WHEN ff.[Ondertekend] = 1 THEN 'Ja' ELSE 'Nee'	END	
									as [Ondertekend]
	  ,ipo.Naam						as [Ondertekenaar Naam]
	  ,ipo.Voornaam					as [Ondertekenaar Voorn.]

    
      ,CASE WHEN ff.[OntvangstCorrect] = 1 THEN 'Ja' ELSE 'Nee'	END	
									as [Ontvangst Correct]

	  ,CASE 
		WHEN ff.[IngediendDoorANB] = 1 THEN 'Door administratie'
		ELSE 'Door aanvrager online'
	  END		
	  								AS [Indieningswijze]

	  ,ipa.Voornaam					AS [Voorn. ingediend door] 
	  ,ipa.Naam						AS [Naam ingediend door]

      ,CASE WHEN ff.[IngediendDoorANB] = 1 THEN 'Ja' ELSE 'Nee'	END	
									as [Ingediend door ANB]

      ,CASE WHEN ff.[NagekekenAnb] = 1 THEN 'Ja' ELSE 'Nee'	END	
									as [Nagekeken door ANB]
	  
	  --,CASE 
	  --	WHEN LEN(IAPSTSTK.FileName) > 0 THEN 'Ja'
	  --	ELSE 'Nee'
	  --END							AS [Papieren dossier aanwezig]

	  --,CASE 
		--WHEN LEN(IAEBIJL.FileName) > 0 THEN 'Ja'
		--ELSE 'Nee'
	  --END							AS [Extra bijlage aanwezig]
	
FROM 
	IR.Indiening i
	LEFT JOIN IR.IndieningStatus s
		ON i.IndieningStatusID = s.IndieningStatusID

	LEFT JOIN IR.IndieningTypeVersie iv 
		on i.IndieningTypeVersieID = iv.IndieningTypeVersieID

	LEFT JOIN IR.IndieningPartij ipi 
		on ipi.IndieningID = i.IndieningID
			AND ipi.IndieningPartijTypeID = 'INDR' -- Indiener

	LEFT JOIN IR.IndieningPartij ipb
		on ipb.IndieningID = i.IndieningID 
			AND ipb.IndieningPartijTypeID = 'BSTRDR'  -- Bestrijder

	LEFT JOIN IR.IndieningPartij ipo 
		on ipo.IndieningID = i.IndieningID --ipo -ipb
			AND ipo.IndieningPartijTypeID = 'ONDTKNR' -- Ondertekenaar

	LEFT JOIN IR.IndieningPartij ipa
		ON ipa.IndieningID = i.IndieningID 
		AND ipa.IndieningPartijTypeID = 'CRTB'

	LEFT JOIN IR.PartijAdres pai --  partij adres Indiener
		on pai.IndieningPartijID = ipi.IndieningPartijID

	LEFT JOIN IR.PartijAdres pab --  partij adres Bestrijder
		on pab.IndieningPartijID = ipb.IndieningPartijID

	LEFT JOIN IR.PartijIdentificatie RRN -- rijkreg nr van de bestrijder
		ON RRN.IndieningPartijID = ipb.IndieningPartijID 
				AND RRN.PartijIdentificatieTypeID = 'RIJKSRNR'

	LEFT JOIN LaatsteJachtVerlof ljv --laatste jachterverlofnr van de bestrijder
		ON ljv.RijksregisterNummer = RRN.Waarde

	LEFT JOIN FF.IndieningFaunaFlora ff 
		on ff.IndieningID = i.IndieningID
	LEFT JOIN FF.IndieningTeBeperkenSchade itbs
		on itbs.IndieningID = i.IndieningID
	LEFT JOIN FF.SchadeType st
		on st.SchadeTypeID = itbs.TeBeperkenSchadeTypeID
	LEFT JOIN FF.IndieningSchadeType ist
		on ist.IndieningSchadeTypeID = itbs.TeBeperkenSchadeTypeID

	LEFT JOIN GIS.IndieningLocatie loc
		on loc.IndieningID = i.IndieningID
	LEFT JOIN GIS.LocatiePerceel per
		on per.IndieningLocatieID = loc.IndieningLocatieID

	LEFT JOIN FF.MeldingBestrijding mb 
		on mb.IndieningID = i.IndieningID
	LEFT JOIN FF.Bestrijdingsactie ba
		on ba.BestrijdingsactieID = mb.BestrijdingsactieID

	/*
    LEFT JOIN FF.WildSchade mbws --?
		on mbws.SchadeTypeID = mb.VerwachteSchadeID
	LEFT JOIN ff.SchadeType mbst --?
		on mbst.SchadeTypeID = mb.VerwachteSchadeID
	LEFT JOIN ff.IndieningSchadeType mbist --?
		on mbist.IndieningSchadeTypeID = mb.VerwachteSchadeID
	*/

	LEFT JOIN FF.MeldingBestrijdingDatum mbd
		on mbd.IndieningID = i.IndieningID

	LEFT JOIN FF.WildSchade ws
		on ws.IndieningID = i.IndieningID
	LEFT JOIN FF.SchadeType wsst
		on wsst.SchadeTypeID = ws.SchadeTypeID

	LEFT JOIN FF.Diersoort ds 
		on ff.DiersoortID = ds.DiersoortID

	--LEFT JOIN IndieningAttachments IAPSTSTK 
	--	ON IAPSTSTK.IndieningID = i.IndieningID 
	--	AND IAPSTSTK.AttachmentDocumentTypeID = 'PSTSTK' -- papieren dossier

    --LEFT JOIN IndieningAttachments IAEBIJL 
	--	ON IAEBIJL.IndieningID = i.IndieningID 
	--	AND IAEBIJL.AttachmentDocumentTypeID = 'EBIJL' -- extra bijlage
	
WHERE 
	i.SnapshotIndieningID is null
	AND iv.IndieningTypeID like 'BSTRDNG%'
	AND i.IndieningStatusID = 'ENT'
	--AND i.IndieningID = 789660

--ORDER BY 
--	 i.IndieningID Desc
--	,i.IndieningTypeVersieID
--	,i.ProvincieID