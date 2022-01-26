CREATE TABLE [Verkennota].[NatuurstreefbeeldCategorie] (
    [NatuurstreefbeeldCategorieID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [NatuurstreefbeeldCategorieTypeID] NVARCHAR (15)  NOT NULL,
    [IndieningID]                      INT            NOT NULL,
    [Beschrijving]                     NVARCHAR (MAX) NULL,
    [SoftDeleted]                      BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                       ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([NatuurstreefbeeldCategorieID] ASC),
    CONSTRAINT [FK_NatuurstreefbeeldCategorie_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID]),
    CONSTRAINT [FK_NatuurstreefbeeldCategorie_NatuurstreefbeeldCategorieType] FOREIGN KEY ([NatuurstreefbeeldCategorieTypeID]) REFERENCES [Verkennota].[NatuurstreefbeeldCategorieType] ([NatuurstreefbeeldCategorieTypeID])
);

