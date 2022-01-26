

CREATE VIEW [dbo].[vMeldingBestrijding]
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
	  ,CASE 
			WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN 'Bestrijding' 
			WHEN iv.IndieningTypeID like 'BZJCHT%' THEN 'Bijz. Jacht' 
			ELSE 'Onbekend' 
		END							as [Indiening Type]

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
		
	  --,CASE 
	---	WHEN iho.IndieningPartijHoedanigheidTypeID = 'EGNR' THEN 'Eigenaar'
	--	WHEN iho.IndieningPartijHoedanigheidTypeID = 'GRNDGBRKR' THEN 'GrondGebruiker'
	  ,CASE WHEN iht.Description IS NULL THEN 'Onbekend' ELSE iht.Description END 
									as [Indiener Hoedanigheid]

	  ,UPPER(ds.Description)		as [Diersoort]

	  ,ist.Description				as [Te Beperken Schade Cat.]
	  ,CASE 
			WHEN iv.IndieningTypeID like 'BZJCHT%' AND itbs.Commentaar IS NULL		THEN mbzj.SchadeTeVoorkomen	
			WHEN iv.IndieningTypeID like 'BZJCHT%' AND itbs.Commentaar IS NOT NULL	THEN itbs.Commentaar
			WHEN iv.IndieningTypeID like 'BSTRDNG%'									THEN itbs.Commentaar
			ELSE 'Onbekend'			
		END							as [Te beperken Schade Beschr.]

	  ,CASE 
			WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN mb.VerwachteSchadeID	
			WHEN iv.IndieningTypeID like 'BZJCHT%'	THEN mbzj.VerwachteSchadeID 
			ELSE 'Onbekend' 
		END							as [Verwachte Schade Cat.]
	  ,CASE 
			WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN mb.VerwachteSchadeToelichting	
			WHEN iv.IndieningTypeID like 'BZJCHT%'	THEN mbzj.VerwachteSchadeToelichting	
			ELSE 'Onbekend' 
		END							as [Verwachte Schade Toelichting.]

	  ,loc.Beschrijving				as [Kadastraal Perceelnr]
	 
	   ,CASE 
			WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN ba.Description
			WHEN iv.IndieningTypeID like 'BZJCHT%'	THEN mbzjba.Description 
			ELSE 'Onbekend' 
		END							as [Preventieve Maatreg.]


	  ,CASE WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN mb.MeldingBestrijdingDatumTypeID			ELSE 'nvt' END		as [Bestrijding Datum Type]
	  ,CASE WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN FORMAT(mb.DatumPeriodeVan,'dd/MM/yyyy')	ELSE 'nvt' END		as [Periode Bestrijding Van]
	  ,CASE WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN FORMAT(mb.DatumPeriodeTot,'dd/MM/yyyy')	ELSE 'nvt' END		as [Periode Bestrijding Tot]
	  ,CASE WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN FORMAT(mbd.Datum,'dd/MM/yyyy')				ELSE 'nvt' END		as [Datum Bestrijding]
	
	  ,CASE WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN ipb.Voornaam	ELSE 'nvt' END				as [Bestrijder Voorn.]
	  ,CASE WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN ipb.Naam		ELSE 'nvt' END				as [Bestrijder Naam]
	  ,CASE WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN ipb.Telefoon	ELSE 'nvt' END				as [Bestrijder Tel]
	  ,CASE WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN ipb.Email		ELSE 'nvt' END				as [Bestrijder E-mail]
	  ,CASE WHEN iv.IndieningTypeID like 'BSTRDNG%' THEN ljv.JachtVerlofNummer	ELSE 'nvt' END		as [Bestrijder Jachtverlofnr]
	
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

	LEFT JOIN IR.IndieningPartijHoedanigheid iho-- partij Indiener Hoedanigheid
		on iho.IndieningPartijID = ipi.IndieningPartijID
	LEFT JOIN IR.IndieningPartijHoedanigheidType iht-- partij Indiener Hoedanigheid Type
		on iht.IndieningPartijHoedanigheidTypeID = iho.IndieningPartijHoedanigheidTypeID
		

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

	LEFT JOIN FF.MeldingBestrijdingDatum mbd
		on mbd.IndieningID = i.IndieningID

	LEFT JOIN FF.WildSchade ws
		on ws.IndieningID = i.IndieningID
	LEFT JOIN FF.SchadeType wsst
		on wsst.SchadeTypeID = ws.SchadeTypeID

	LEFT JOIN FF.Diersoort ds 
		on ff.DiersoortID = ds.DiersoortID

	----------------------------------------------------

	Left Join FF.MeldingBijzondereJacht mbzj
		on mbzj.IndieningID = i.IndieningID
	LEFT JOIN FF.Bestrijdingsactie mbzjba
		on mbzjba.BestrijdingsactieID = mbzj.BestrijdingsactieID


	--LEFT JOIN IndieningAttachments IAPSTSTK 
	--	ON IAPSTSTK.IndieningID = i.IndieningID 
	--	AND IAPSTSTK.AttachmentDocumentTypeID = 'PSTSTK' -- papieren dossier

    --LEFT JOIN IndieningAttachments IAEBIJL 
	--	ON IAEBIJL.IndieningID = i.IndieningID 
	--	AND IAEBIJL.AttachmentDocumentTypeID = 'EBIJL' -- extra bijlage
	
WHERE 
	i.SnapshotIndieningID is null
	AND (iv.IndieningTypeID like 'BSTRDNG%' OR iv.IndieningTypeID like 'BZJCHT%')
	AND i.IndieningStatusID = 'ENT'
	--AND i.IndieningID IN (781183,789660,665687,110117,756532)

--ORDER BY 
--	 i.IndieningID Desc
--	,i.IndieningTypeVersieID
--	,i.ProvincieID