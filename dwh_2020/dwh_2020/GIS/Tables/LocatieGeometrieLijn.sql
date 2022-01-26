CREATE TABLE [GIS].[LocatieGeometrieLijn] (
    [IndieningLocatieID] INT              NOT NULL,
    [Naam]               VARCHAR (255)    NULL,
    [Bron]               VARCHAR (255)    NULL,
    [BronWaarde]         VARCHAR (255)    NULL,
    [DatumToegevoegd]    DATETIME         NULL,
    [SHAPE]              [sys].[geometry] NULL,
    CONSTRAINT [PK_LocatieGeometrieLijn] PRIMARY KEY CLUSTERED ([IndieningLocatieID] ASC),
    CONSTRAINT [FK_LocatieGeometrieLijn_IndieningLocatie] FOREIGN KEY ([IndieningLocatieID]) REFERENCES [GIS].[IndieningLocatie] ([IndieningLocatieID])
);

