CREATE TABLE [GIS].[LocatieGeometriePoly] (
    [IndieningLocatieID] INT              NOT NULL,
    [Naam]               VARCHAR (255)    NULL,
    [Bron]               VARCHAR (255)    NULL,
    [BronWaarde]         VARCHAR (255)    NULL,
    [DatumToegevoegd]    DATETIME         NULL,
    [SHAPE]              [sys].[geometry] NULL,
    CONSTRAINT [PK_LocatieGeometriePoly] PRIMARY KEY CLUSTERED ([IndieningLocatieID] ASC),
    CONSTRAINT [FK_LocatieGeometriePoly_IndieningLocatie] FOREIGN KEY ([IndieningLocatieID]) REFERENCES [GIS].[IndieningLocatie] ([IndieningLocatieID])
);

