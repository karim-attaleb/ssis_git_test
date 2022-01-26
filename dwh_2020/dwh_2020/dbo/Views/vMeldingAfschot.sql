
CREATE VIEW [dbo].[vMeldingAfschot]
AS 

--USE IndieningRegister

WITH IndieningAttachments (IndieningID, AttachmentDocumentTypeID, FileName)
AS(
	SELECT I.IndieningId, AINFO.AttachmentDocumentTypeID, AINFO.FileName
    FROM [IndieningRegister].[IR].[Indiening] I
		JOIN [IndieningRegister].[IR].[AttachmentSet] ASET ON I.AttachmentSetID = ASET.AttachmentSetID
		JOIN [IndieningRegister].[IR].[AttachmentInfo] AINFO ON ASET.AttachmentSetID = AINFO.AttachmentSetID
)

SELECT					
	   i.IndieningID				as [Indiening ID]
	  ,i.VersieNummer				as [Versie Nr]
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
	  ,i.DossierNummer				as [Dossier Nr]

	  ,ipi.Voornaam					as [Indiener Voornaam]
	  ,ipi.Naam						as [Indiener Naam]
	  --,ipi.NationaliteitID			as [Indiener Nation. ID]
	  ,(SELECT NAT.Description FROM [MasterData].[dbo].[Nationaliteit] NAT WHERE NAT.NationaliteitID = ipi.NationaliteitID) 
									as [Indiener Nation.]
	  ,FORMAT(ipi.Geboortedatum,'dd/MM/yyyy')				
									as [Indiener Geb. Datum]
	  ,ipi.GeslachtID				as [Indiener Geslacht]
	  ,ipi.Telefoon					as [Indiener Telefoon]
	  ,ipi.Email					as [Indiener Email]
	  ,pai.GemeenteNaam				as [Indiener Gemeente]
	  ,pai.GemeentePostCode			as [Indiener Postcode]
	  ,pai.Straatnaam				as [Indiener Straatnaam]
	  ,pai.Huisnummer				as [Indiener Huis Nr]
	  --,pai.LandID					as [Indiener LandID]
	  ,(SELECT LND.Description FROM [MasterData].[dbo].[Land] LND WHERE LND.LandID = pai.LandID) 
									as [Indiener Land]

	  ,ips.Voornaam					as [Schutter Voornaam]
	  ,ips.Naam						as [Schutter Naam]
	  --,ips.NationaliteitID		as [Schutter Nation.]
	  --,FORMAT(ips.Geboortedatum,'dd/MM/yyyy')				
	  --							as [Schutter Geb. Datum]
	  -- ,ips.GeslachtID			as [Schutter Geslacht]
	  ,ips.Telefoon					as [Schutter Telefoon]
	  --,ips.Email					as [Schutter Email]
	  --,pas.GemeenteNaam			as [Schutter Gemeente]
	  --,pas.GemeentePostCode		as [Schutter Postcode]


	  --,ff.[DiersoortID]				as [Diersoort ID]
	  ,UPPER(ds.Description)		as [Diersoort]
	  ,ma.AfschotPlanNummer			as [Afschotplan Nr]

	  ,FORMAT(mad.[Datum],'dd/MM/yyyy')					
									as [Datum Afschot]
      ,mad.[Tijdstip]				as [Tijdstip Afschot]
	  ,mad.[PostCode]				as [Postcode]
	  ,mad.[GemeenteNaam]			as [Gemeente]
	  ,CASE WHEN i.ProvincieID IS NULL THEN '_Onbekend' ELSE i.ProvincieID END
									as [Prov. ID]
	  ,mad.[Xcoordinaat]			as [X-coord.]
      ,mad.[Ycoordinaat]			as [Y-coord.]
	  ,mad.[PuntLocatieTypeID]
     
      --mad.[GemeenteNisCode]		as [Gemeente NIS]
      ,mad.[LabelNummer]			as [Label Nr]
      ,CASE 
			WHEN mad.[GroepID] = 'GRP' THEN 'Groep' 
			WHEN mad.[GroepID] = 'NBKND' THEN 'Onbekend' 
			WHEN mad.[GroepID] = 'ALLN' THEN 'Solitair' 
			ELSE '--'+mad.[GroepID]+'--' 
	   END
									as [Groep Info]
      ,mad.[AantalDieren]			as [Groep Aantal Dieren]

      --,CASE WHEN mad.[LeeftijdDierID] IS NULL THEN '_Onbekend' ELSE mad.[LeeftijdDierID]	END
	  --							as [Dier Leeftijd ID]
	  ,CASE 
			WHEN mad.[LeeftijdDierID] IS NULL	THEN '_Onbekend'
			WHEN mad.[LeeftijdDierID] = 'FRSLNG'	THEN 'FRISLING'
			WHEN mad.[LeeftijdDierID] = 'OVRLPR'	THEN 'OVERLOPER'
			WHEN mad.[LeeftijdDierID] = 'KLF'		THEN 'KALF'
			WHEN mad.[LeeftijdDierID] = 'JNGVLWSN'	THEN 'JONGVOLWASSEN'
			WHEN mad.[LeeftijdDierID] = 'VLWSN'		THEN 'VOLWASSEN'
			WHEN mad.[LeeftijdDierID] = 'KTS'		THEN 'KITS'
			ELSE mad.[LeeftijdDierID]
		END AS [Dier Leeftijd]

      ,CASE WHEN mad.[GeslachtDierID] IS NULL THEN '_Onbekend' ELSE LEFT(mad.[GeslachtDierID],1) END	
									as [Dier Geslacht]

      ,CASE WHEN mad.[IsAantalEmbryosBekend] = 1 THEN 'Ja' ELSE 'Nee'	END	
									as [Aantal Embryos Bekend]
	  ,mad.[AantalEmbryos]			as [Aantal Embryos]
	  --,mad.GewichtTypeID			as [Gewicht Type]
      ,mad.[Gewicht]				as [Gewicht]

	   , CASE 
			WHEN mad.[Gewicht] <= 10							THEN '1'
			WHEN mad.[Gewicht] > 10 AND mad.[Gewicht] <= 20		THEN '2'
			WHEN mad.[Gewicht] > 20 AND mad.[Gewicht] <= 30		THEN '3'
			WHEN mad.[Gewicht] > 30 AND mad.[Gewicht] <= 50		THEN '4'
			WHEN mad.[Gewicht] > 50 AND mad.[Gewicht] <= 100	THEN '5'
			WHEN mad.[Gewicht] > 100 AND mad.[Gewicht] <= 150	THEN '6'
			WHEN mad.[Gewicht] > 150							THEN '7'
		ELSE
			'_Onbekend'
		END
									as [Gewichtsklasse]
	  , CASE 
			WHEN mad.[Gewicht] <= 10							THEN '0 -> 10 kg'
			WHEN mad.[Gewicht] > 10 AND mad.[Gewicht] <= 20		THEN '+10 -> 20 kg'
			WHEN mad.[Gewicht] > 20 AND mad.[Gewicht] <= 30		THEN '+20 -> 30 kg'
			WHEN mad.[Gewicht] > 30 AND mad.[Gewicht] <= 50		THEN '+30 -> 50 kg'
			WHEN mad.[Gewicht] > 50 AND mad.[Gewicht] <= 100	THEN '+50 -> 100 kg'
			WHEN mad.[Gewicht] > 100 AND mad.[Gewicht] <= 150	THEN '+100 -> 150 kg'
			WHEN mad.[Gewicht] > 150							THEN '+150 kg'
		ELSE
			''
		END
									as [Gewichtskl. Omschrijv.]

	  ,mad.[Stalen]					as [Type Stalen]
	  ,CASE WHEN mad.[IsDierenarts] = 1 THEN 'Ja' ELSE 'Nee'	END	
									as [Stalen afgenomen door Dierenarts?]

      ,mad.[LengteOnderkaakLinks]	as [Lengte O.Kaak L]
      ,mad.[LengteOnderkaakRechts]	as [Lengte O.Kaak R]
      
      ,mad.[NaamDierenarts]			as [Naam Dierenarts]
      ,mad.[VoornaamDierenarts]		as [Voornaam Dierenarts]
      ,mad.[OrdeNummerDierenarts]	as [Orde Nr Dierenarts]
      ,REPLACE(REPLACE(mad.[OpmerkingDierenarts], CHAR(13), ''), CHAR(10), '')  
									as [Opmerking Dierenarts]
      ,REPLACE(REPLACE(mad.[Opmerkingen], CHAR(13), ''), CHAR(10), '')  
									as [Opmerkingen]      



	  ,ma.MeldingAfschotDierID		as [Melding Afschot Dier ID]
	  ,ma.JachtmethodeID			as [Jachtmethode ID]
	  ,CASE 
			WHEN ma.[JachtmethodeID] = 'AANZTJCHT' THEN 'Aanzitjacht'
			WHEN ma.[JachtmethodeID] = 'ALCHTAANZTJCHT' THEN 'Aanzitjacht op aankorrelplaats met wapen met lichtbron'
			WHEN ma.[JachtmethodeID] = 'BRSJCHT' THEN 'Bersjacht'
			WHEN ma.[JachtmethodeID] = 'DRFJCHT' THEN 'Drijfjacht'
			WHEN ma.[JachtmethodeID] = 'HLPAANZTJCHT' THEN 'Aanzitjacht zonder bijkomende hulpmiddelen'
			WHEN ma.[JachtmethodeID] = 'KOOIJCHT' THEN 'Kastval of kooival'
			WHEN ma.[JachtmethodeID] = 'DRKJCHT' THEN 'Drukjacht'
			WHEN ma.[JachtmethodeID] = 'KORAANZTJCHT' THEN 'Aanzitjacht op aankorrelplaats'
			WHEN ma.[JachtmethodeID] = 'LCHTAANZTJCHT' THEN 'Aanzitjacht met wapen met lichtbron'
			WHEN ma.[JachtmethodeID] = 'VANGST' THEN 'Vangst'
			ELSE ''
	  END							as [Jachtmethode]

	  ,CASE 
			WHEN ma.[WettelijkKaderID] = 'GWNJCHT' THEN 'Gewone jacht'
			WHEN ma.[WettelijkKaderID] = 'BSTRDNGJCHTDCRT' THEN 'Bestrijding volgens artikel 22 van het Jachtdecreet'
			WHEN ma.[WettelijkKaderID] = 'BZNDRJCHT' THEN 'Bijzondere jacht'
			WHEN ma.[WettelijkKaderID] = 'JCHTDCRTBZVLDW' THEN 'Bestrijding volgens artikel 22 van het Jachtdecreet door de bijzonder veldwachter'
			ELSE ma.[WettelijkKaderID]
		END							as [Wettelijk kader]


	  ,CASE WHEN ff.[Ondertekend] = 1 THEN 'Ja' ELSE 'Nee'	END	
									as [Ondertekend]
	  ,ipo.Naam						as [Ondertekenaar Naam]
	  ,ipo.Voornaam					as [Ondertekenaar Voornaam]

    
      ,CASE WHEN ff.[OntvangstCorrect] = 1 THEN 'Ja' ELSE 'Nee'	END	
									as [Ontvangst Correct]

		 
	  ,CASE 
		WHEN LEN(IAPSTSTK.FileName) > 0 OR ff.OntvangstDatum is not null THEN 'Door administratie'
		ELSE 'Door aanvrager online'
	  END							AS [Indieningswijze_Old]

	  ,CASE 
		WHEN ff.[IngediendDoorANB] = 1 THEN 'Door administratie'
		ELSE 'Door aanvrager online'
	  END		
	  								AS [Indieningswijze]

	  ,ipa.Voornaam				AS [Voornaam ingediend door] 
	  ,ipa.Naam					AS [Achternaam ingediend door]

      ,CASE WHEN ff.[IngediendDoorANB] = 1 THEN 'Ja' ELSE 'Nee'	END	
									as [Ingediend door ANB]

      ,CASE WHEN ff.[NagekekenAnb] = 1 THEN 'Ja' ELSE 'Nee'	END	
									as [Nagekeken door ANB]
      ,CASE WHEN ff.[NagekekenInbo]	 = 1 THEN 'Ja' ELSE 'Nee'	END	
									as [Nagekeken door INBO]
	  
	  
	  ,CASE 
		WHEN LEN(IAPSTSTK.FileName) > 0 THEN 'Ja'
		ELSE 'Nee'
	  END							AS [Papieren dossier aanwezig]

	  ,CASE 
		WHEN LEN(IAEBIJL.FileName) > 0 THEN 'Ja'
		ELSE 'Nee'
	  END							AS [Extra bijlage aanwezig]
	

	 --,mad.[PuntLocatieTypeID]
	 
	  ,CAST(i.IndieningID as nvarchar(200))
			+'-'+ CAST(isnull(i.IndieningTypeVersieID,'')  as nvarchar(200))
			+'-'+ CAST(isnull(i.DossierNummer,'') as nvarchar(200)) 
			+'-'+ CAST(isnull(ma.AfschotPlanNummer,'') as nvarchar(200))	
			+'-'+ CAST(isnull(ma.JachtmethodeID,'') as nvarchar(200))
			+'-'+ CAST(isnull(
				CASE 
					WHEN ma.[JachtmethodeID] IS NULL THEN '_Onbekend'
					WHEN ma.[JachtmethodeID] = 'AANZTJCHT' THEN 'Aanzitjacht'
					WHEN ma.[JachtmethodeID] = 'ALCHTAANZTJCHT' THEN 'Aanzitjacht op aankorrelplaats met wapen met lichtbron'
					WHEN ma.[JachtmethodeID] = 'BRSJCHT' THEN 'Bersjacht'
					WHEN ma.[JachtmethodeID] = 'DRFJCHT' THEN 'Drijfjacht'
					WHEN ma.[JachtmethodeID] = 'HLPAANZTJCHT' THEN 'Aanzitjacht zonder bijkomende hulpmiddelen'
					WHEN ma.[JachtmethodeID] = 'KOOIJCHT' THEN 'Kastval of kooival'
					WHEN ma.[JachtmethodeID] = 'DRKJCHT' THEN 'Drukjacht'
					WHEN ma.[JachtmethodeID] = 'KORAANZTJCHT' THEN 'Aanzitjacht op aankorrelplaats'
					WHEN ma.[JachtmethodeID] = 'LCHTAANZTJCHT' THEN 'Aanzitjacht met wapen met lichtbron'
					WHEN ma.[JachtmethodeID] = 'VANGST' THEN 'Vangst'
					ELSE ''
				END	,'') as nvarchar(200))							

			+'-'+ CAST(isnull(
				CASE 
					WHEN ma.[WettelijkKaderID] IS NULL THEN '_Onbekend'
					WHEN ma.[WettelijkKaderID] = 'GWNJCHT' THEN 'Gewone jacht'
					WHEN ma.[WettelijkKaderID] = 'BSTRDNGJCHTDCRT' THEN 'Bestrijding volgens artikel 22 van het Jachtdecreet'
					WHEN ma.[WettelijkKaderID] = 'BZNDRJCHT' THEN 'Bijzondere jacht'
					WHEN ma.[WettelijkKaderID] = 'JCHTDCRTBZVLDW' THEN 'Bestrijding volgens artikel 22 van het Jachtdecreet door de bijzonder veldwachter'
					ELSE ma.[WettelijkKaderID]
				END	,'') as nvarchar(200))					

			+'-'+ CAST(isnull(ma.MeldingAfschotDierID,'') as nvarchar(200))		

	 		+'-'+ CAST(REPLACE(REPLACE(isnull(FF.Commentaar,''), CHAR(13), ''), CHAR(10), '') as nvarchar(max)) 

	 		+'-'+ CAST(isnull(ipi.Naam,'') as nvarchar(200))
	 		+'-'+ CAST(isnull(ipi.Voornaam,'') as nvarchar(200))
	 		+'-'+ CAST(isnull(ipi.NationaliteitID,'') as nvarchar(200))
	 		+'-'+ CAST(isnull(ipi.Telefoon,'') as nvarchar(200))	
			+'-'+ CAST(isnull(ipi.Email,'') as nvarchar(200))	

			+'-'+ CAST(isnull(pai.straatnaam,'') as nvarchar(200))	
			+'-'+ CAST(isnull(pai.Huisnummer,'') as nvarchar(200))	
			+'-'+ CAST(isnull(pai.LandID,'') as nvarchar(200))	
			+'-'+ CAST(isnull(pai.GemeenteNaam,'') as nvarchar(200))		
			+'-'+ CAST(isnull(pai.GemeentePostCode,'') as nvarchar(200))	
			+'-'+ CAST(isnull(ips.Naam,'') as nvarchar(200))			
			+'-'+ CAST(isnull(ips.Voornaam,'') as nvarchar(200))	
			+'-'+ CAST(isnull(ips.Telefoon,'') as nvarchar(200))		

	 		+'-'+ CAST(isnull(mad.[GemeenteNaam],'') as nvarchar(200))	
	 		+'-'+ CAST(isnull(mad.[PostCode],'') as nvarchar(200))	
	 		+'-'+ CAST(isnull(mad.[GemeenteNisCode],'') as nvarchar(200))
	 		+'-'+ CAST(isnull(mad.[LabelNummer],'') as nvarchar(200))

			+'-'+ CAST(isnull(ipo.Naam,'') as nvarchar(200))			
			+'-'+ CAST(isnull(ipo.Voornaam,'') as nvarchar(200))		

	 		+'-'+ CAST(
				CASE 
					WHEN mad.[GroepID] IS NULL THEN '' 
					WHEN mad.[GroepID] = 'GRP' THEN 'Groep' 
					WHEN mad.[GroepID] = 'NBKND' THEN 'Onbekend' 
					WHEN mad.[GroepID] = 'ALLN' THEN 'Solitair' 
					ELSE '--'+mad.[GroepID]+'--' 
				END
				as nvarchar(200))
	 		+'-'+ CAST(CASE WHEN mad.[LeeftijdDierID] IS NULL THEN '_Onbekend' ELSE mad.[LeeftijdDierID] END as nvarchar(200))

			+'-'+ CAST(
				CASE 
					WHEN mad.[LeeftijdDierID] IS NULL		THEN '_Onbekend'
					WHEN mad.[LeeftijdDierID] = 'FRSLNG'	THEN 'FRISLING'
					WHEN mad.[LeeftijdDierID] = 'OVRLPR'	THEN 'OVERLOPER'
					WHEN mad.[LeeftijdDierID] = 'KLF'		THEN 'KALF'
					WHEN mad.[LeeftijdDierID] = 'JNGVLWSN'	THEN 'JONGVOLWASSEN'
					WHEN mad.[LeeftijdDierID] = 'VLWSN'		THEN 'VOLWASSEN'
					WHEN mad.[LeeftijdDierID] = 'KTS'		THEN 'KITS'
					ELSE mad.[LeeftijdDierID]
				END 
				as nvarchar(200))

	 		+'-'+ CAST(isnull(mad.[NaamDierenarts],'') as nvarchar(200))			
     		+'-'+ CAST(isnull(mad.[VoornaamDierenarts],'') as nvarchar(200))		
     		+'-'+ CAST(isnull(mad.[OrdeNummerDierenarts],'') as nvarchar(200))	
     		+'-'+ CAST(REPLACE(REPLACE(isnull(mad.[OpmerkingDierenarts],''), CHAR(13), ''), CHAR(10), '') as nvarchar(max))  							
     		+'-'+ CAST(REPLACE(REPLACE(isnull(mad.[Opmerkingen],''), CHAR(13), ''), CHAR(10), '') as nvarchar(max))  
			
									as [Tekst]			
	
FROM 
	IR.Indiening i
	LEFT JOIN FF.IndieningFaunaFlora ff 
		on ff.IndieningID = i.IndieningID
	LEFT JOIN IR.IndieningTypeVersie iv 
		on i.IndieningTypeVersieID = iv.IndieningTypeVersieID

	LEFT JOIN IR.IndieningPartij ipi 
		on ipi.IndieningID = i.IndieningID
			AND ipi.IndieningPartijTypeID = 'INDR' -- Indiener

	LEFT JOIN IR.IndieningPartij ips
		on ips.IndieningID = i.IndieningID 
			AND ips.IndieningPartijTypeID = 'SCHTTR'  -- Schutter

	LEFT JOIN IR.IndieningPartij ipo 
		on (ips.IndieningID = ipo.IndieningID 
			AND ipo.IndieningPartijTypeID = 'ONDTKNR') -- Ondertekenaar

	LEFT JOIN IR.PartijAdres pai --  partij adres Indiener
		on pai.IndieningPartijID = ipi.IndieningPartijID

	LEFT JOIN IR.PartijAdres pas --  partij adres Schutter
		on pas.IndieningPartijID = ips.IndieningPartijID

	LEFT JOIN FF.MeldingAfschot ma 
		on ma.IndieningID = i.IndieningID
	LEFT JOIN FF.MeldingAfschotDier mad 
		on mad.IndieningID = i.IndieningID
	LEFT JOIN FF.Diersoort ds 
		on ff.DiersoortID = ds.DiersoortID

	LEFT JOIN IndieningAttachments IAPSTSTK 
		ON IAPSTSTK.IndieningID = i.IndieningID 
		AND IAPSTSTK.AttachmentDocumentTypeID = 'PSTSTK' -- papieren dossier

    LEFT JOIN IndieningAttachments IAEBIJL 
		ON IAEBIJL.IndieningID = i.IndieningID 
		AND IAEBIJL.AttachmentDocumentTypeID = 'EBIJL' -- extra bijlage

	LEFT JOIN [IndieningRegister].[IR].[IndieningStatus] s
		ON i.IndieningStatusID = s.IndieningStatusID

	LEFT JOIN [IndieningRegister].[IR].[IndieningPartij] ipa
		ON i.IndieningID = ipa.IndieningID 
		AND ipa.IndieningPartijTypeID = 'CRTB'

	
WHERE 
	i.SnapshotIndieningID is null
	AND iv.IndieningTypeID like 'AFSCHT_%'
	AND i.IndieningStatusID = 'ENT'

--ORDER BY 
--	 i.IndieningID Desc
--	,i.IndieningTypeVersieID
--	,i.ProvincieID