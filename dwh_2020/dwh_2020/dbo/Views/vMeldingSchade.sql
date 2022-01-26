

CREATE VIEW [dbo].[vMeldingSchade]
AS 


SELECT		
	   i.IndieningID				as [ID]
	  ,iv.IndieningTypeID

	  ,loc.Beschrijving
	  ,loc.IndieningPartijID
	  ,loc.LocatieTypeID
	  ,loc.IndieningLocatieID
	  ,loc.IndieningLocatieTypeID

	 --,lty.Description


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
	  
--	  ,ipi.Voornaam					as [Indiener Voorn.]
	  ,ipi.Naam						as [Indiener Naam]
	  --,ipi.NationaliteitID			as [Indiener Nation. ID]
	  ,(SELECT NAT.Description FROM [MasterData].[dbo].[Nationaliteit] NAT WHERE NAT.NationaliteitID = ipi.NationaliteitID) 
									as [Indiener Nation.]
	  ,FORMAT(ipi.Geboortedatum,'dd/MM/yyyy')				
									as [Indiener Geb. Datum]
	  ,ipi.GeslachtID				as [Indiener Geslacht]
	  ,ipi.Telefoon					as [Indiener Tel]
--	  ,ipi.Email					as [Indiener E-mail]
--	  ,pai.GemeenteNaam				as [Indiener Gemeente]
--	  ,pai.GemeentePostCode			as [Indiener Postcode]
--	  ,pai.Straatnaam				as [Indiener Straat]
--	  ,pai.Huisnummer				as [Indiener Huisnr]
	  --,pai.LandID					as [Indiener LandID]
--	  ,(SELECT LND.Description FROM [MasterData].[dbo].[Land] LND WHERE LND.LandID = pai.LandID) 
--									as [Indiener Land]
	
--	  ,CASE WHEN iht.Description IS NULL THEN 'Onbekend' ELSE iht.Description END 
--									as [Indiener Hoedanigheid]

	  ,UPPER(ds.Description)		as [Diersoort]

	  ,loc.Beschrijving				as [Kadastraal Perceelnr]
	
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
	  ,sd.*
	  ,ps.Description
	

FROM 
	IndieningRegister.IR.Indiening i
	LEFT JOIN IR.IndieningStatus s
		ON i.IndieningStatusID = s.IndieningStatusID

	LEFT JOIN IR.IndieningTypeVersie iv 
		on i.IndieningTypeVersieID = iv.IndieningTypeVersieID

	LEFT JOIN IR.IndieningPartij ipi 
		on ipi.IndieningID = i.IndieningID
			AND ipi.IndieningPartijTypeID = 'INDR' -- Indiener

	LEFT JOIN IR.PartijAdres pai --  partij adres Indiener
		on pai.IndieningPartijID = ipi.IndieningPartijID

	LEFT JOIN IR.IndieningPartijHoedanigheid iho-- partij Indiener Hoedanigheid
		on iho.IndieningPartijID = ipi.IndieningPartijID
	LEFT JOIN IR.IndieningPartijHoedanigheidType iht-- partij Indiener Hoedanigheid Type
		on iht.IndieningPartijHoedanigheidTypeID = iho.IndieningPartijHoedanigheidTypeID

	LEFT JOIN IR.IndieningPartij ipo 
		on ipo.IndieningID = i.IndieningID --ipo -ipb
			AND ipo.IndieningPartijTypeID = 'ONDTKNR' -- Ondertekenaar

	LEFT JOIN IR.IndieningPartij ipa
		ON ipa.IndieningID = i.IndieningID 
		AND ipa.IndieningPartijTypeID = 'CRTB'

	LEFT JOIN GIS.IndieningLocatie loc
		on loc.IndieningID = i.IndieningID

	LEFT JOIN GIS.IndieningLocatieType lty
		on loc.IndieningLocatieTypeID = lty.IndieningLocatieTypeID

	--LEFT JOIN GIS.LocatiePerceel  per -- xxxx werkt niet
	--	on per.IndieningLocatieID = loc.IndieningLocatieID


	--LEFT JOIN FF.IndieningLocatieFaunaFlora loc2 -- xxxx werkt niet
	--	on loc2.IndieningLocatieID = loc.IndieningLocatieID

	--LEFT JOIN GIS.LocatiePerceel per -- xxxx werkt niet
	--	on per.IndieningLocatieID = loc.IndieningLocatieID

	LEFT JOIN FF.IndieningFaunaFlora ff 
		on ff.IndieningID = i.IndieningID

	--LEFT JOIN FF.IndieningTeBeperkenSchade itbs
	--	on itbs.IndieningID = i.IndieningID
	--LEFT JOIN FF.SchadeType st
	--	on st.SchadeTypeID = itbs.TeBeperkenSchadeTypeID
	--LEFT JOIN FF.IndieningSchadeType ist
	--	on ist.IndieningSchadeTypeID = itbs.TeBeperkenSchadeTypeID

	
	LEFT JOIN IndieningRegister.FF.Diersoort ds 
		on ff.DiersoortID = ds.DiersoortID

	LEFT JOIN SchadeDossier.dbo.schadedossier sd -- Nieuwe DB met schadedossier data vanaf okt 2021
			on sd.schadedossier_sk = i.IndieningGUID    --collate SQL_Latin1_General_CP1_CI_AS 

	LEFT JOIN IndieningRegister.FF.Plantsoort ps
			on cast(ps.PlantsoortID as int) = cast(sd.plantsoort as int)

    --LEFT JOIN IndieningRegister.FF.Diersoort ds2  -- probleem: kan niet gejoined worden
	--		on cast(lower(ds2.DiersoortID) as varchar(100))  = cast(lower(sd.diersoorten_type) as varchar(100))


	----------------------------------------------------
	---LEFT JOIN FF.WildSchade ws -------- xxxx
		--on ws.IndieningID = i.IndieningID
	---LEFT JOIN FF.SchadeType wsst
		--on wsst.SchadeTypeID = ws.SchadeTypeID

	--LEFT JOIN FF.IndieningSchade isc ---------- xxxx
	--	on isc.IndieningID = i.IndieningID
	
	--LEFT JOIN FF.SchadeRegistratie sr --------- xxxx
	--	on sr.IndieningID = i.IndieningID

	--LEFT JOIN FF.WildSchadeOpmerkingenVerslagPlaatsbezoek xx ------ xxxx
	--	on xx.IndieningID = i.IndieningID


	--LEFT JOIN IndieningAttachments IAPSTSTK 
	--	ON IAPSTSTK.IndieningID = i.IndieningID 
	--	AND IAPSTSTK.AttachmentDocumentTypeID = 'PSTSTK' -- papieren dossier

    --LEFT JOIN IndieningAttachments IAEBIJL 
	--	ON IAEBIJL.IndieningID = i.IndieningID 
	--	AND IAEBIJL.AttachmentDocumentTypeID = 'EBIJL' -- extra bijlage
	
WHERE 
	i.SnapshotIndieningID is null
	--AND (iv.IndieningTypeID like 'SCHM' OR iv.IndieningTypeID like 'SCHV') --'SCHDRGSTR%'
	AND i.IndieningStatusID = 'ENT'
	AND i.IndieningID IN (796528) --766363

--ORDER BY 
--	 i.IndieningID Desc
--	,i.IndieningTypeVersieID
--	,i.ProvincieID