CREATE TABLE [Verkennota].[IndieningLocatieVerkenningsnota] (
    [IndieningLocatieID] INT            NOT NULL,
    [Bestemming]         NVARCHAR (MAX) NULL,
    [SoftDeleted]        BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]         ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([IndieningLocatieID] ASC),
    CONSTRAINT [FK_IndieningLocatieVerkenningsnota_IndieningLocatie] FOREIGN KEY ([IndieningLocatieID]) REFERENCES [GIS].[IndieningLocatie] ([IndieningLocatieID])
);

