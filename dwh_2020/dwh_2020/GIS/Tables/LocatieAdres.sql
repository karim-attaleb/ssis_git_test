CREATE TABLE [GIS].[LocatieAdres] (
    [IndieningLocatieID] INT            NOT NULL,
    [Straatnaam]         NVARCHAR (50)  NULL,
    [Huisnummer]         NVARCHAR (15)  NULL,
    [Busnummer]          NVARCHAR (15)  NULL,
    [GemeenteNaam]       NVARCHAR (100) NULL,
    [PostCode]           NVARCHAR (15)  NULL,
    [GemeenteNisCode]    NVARCHAR (15)  NULL,
    [LandID]             NVARCHAR (5)   NULL,
    [CrabObjectID]       NVARCHAR (15)  NULL,
    [CrabObjectTypeID]   NVARCHAR (15)  NULL,
    [SoftDeleted]        BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]         ROWVERSION     NOT NULL,
    [Regio]              NVARCHAR (50)  NULL,
    CONSTRAINT [PK_LocatieAdres] PRIMARY KEY CLUSTERED ([IndieningLocatieID] ASC),
    CONSTRAINT [FK_LocatieAdres_CrabObjectTypeID] FOREIGN KEY ([CrabObjectTypeID]) REFERENCES [GIS].[CrabObjectType] ([CrabObjectTypeID]),
    CONSTRAINT [FK_LocatieAdres_Locatie] FOREIGN KEY ([IndieningLocatieID]) REFERENCES [GIS].[IndieningLocatie] ([IndieningLocatieID])
);

