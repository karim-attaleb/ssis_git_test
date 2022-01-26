CREATE TABLE [GIS].[LocatiePunt] (
    [IndieningLocatieID]        INT              NOT NULL,
    [LocatiePuntPrecisieTypeID] INT              NULL,
    [Xcoordinaat]               NVARCHAR (50)    NULL,
    [Ycoordinaat]               NVARCHAR (50)    NULL,
    [Projectiesysteem]          INT              NULL,
    [LocatieGeometriePuntID]    UNIQUEIDENTIFIER NULL,
    [SoftDeleted]               BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]                ROWVERSION       NOT NULL,
    PRIMARY KEY CLUSTERED ([IndieningLocatieID] ASC),
    CONSTRAINT [FK_LocatiePunt_Locatie] FOREIGN KEY ([IndieningLocatieID]) REFERENCES [GIS].[IndieningLocatie] ([IndieningLocatieID]),
    CONSTRAINT [FK_LocatiePunt_LocatiePuntType] FOREIGN KEY ([LocatiePuntPrecisieTypeID]) REFERENCES [GIS].[LocatiePuntPrecisieType] ([LocatiePuntPrecisieTypeID])
);

