CREATE TABLE [GIS].[LocatiePerceel] (
    [IndieningLocatieID]      INT              NOT NULL,
    [LocatieGeometriePolyID]  INT              NULL,
    [CadMapVersie]            NVARCHAR (25)    NOT NULL,
    [PerceelGuid]             UNIQUEIDENTIFIER NULL,
    [AfdelingNisCode]         NVARCHAR (5)     NOT NULL,
    [SectieCode]              NVARCHAR (1)     NOT NULL,
    [PerceelNummer]           NVARCHAR (15)    NOT NULL,
    [PerceelOppervlakte_ha]   DECIMAL (18, 6)  NULL,
    [BetrokkenOppervlakte_ha] DECIMAL (18, 6)  NULL,
    [KadasterGemeenteNisCode] NVARCHAR (15)    NULL,
    [GemeenteNaam]            NVARCHAR (200)   NULL,
    [PostCode]                NVARCHAR (15)    NULL,
    [AfdelingNummer]          SMALLINT         NULL,
    [Versie]                  NVARCHAR (15)    NULL,
    [SoftDeleted]             BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]              ROWVERSION       NOT NULL,
    CONSTRAINT [PK_LocatiePerceel] PRIMARY KEY CLUSTERED ([IndieningLocatieID] ASC),
    CONSTRAINT [FK_LocatiePerceel_Locatie] FOREIGN KEY ([IndieningLocatieID]) REFERENCES [GIS].[IndieningLocatie] ([IndieningLocatieID]),
    CONSTRAINT [UK_LocatiePerceel] UNIQUE NONCLUSTERED ([IndieningLocatieID] ASC, [AfdelingNisCode] ASC, [SectieCode] ASC, [PerceelNummer] ASC)
);

