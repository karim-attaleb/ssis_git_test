CREATE TABLE [Verkennota].[Inventarisatie] (
    [InventarisatieID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [InventarisatieTypeID] NVARCHAR (15)  NOT NULL,
    [IndieningID]          INT            NOT NULL,
    [Beschrijving]         NVARCHAR (MAX) NULL,
    [SoftDeleted]          BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([InventarisatieID] ASC),
    CONSTRAINT [FK_Inventarisatie_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID]),
    CONSTRAINT [FK_Inventarisatie_InventarisatieType] FOREIGN KEY ([InventarisatieTypeID]) REFERENCES [Verkennota].[InventarisatieType] ([InventarisatieTypeID])
);

