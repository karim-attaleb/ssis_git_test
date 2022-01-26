CREATE TABLE [Verkennota].[EconomischeFunctie] (
    [EconomischeFunctieID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]              INT            NOT NULL,
    [EconomischeFunctieTypeID] NVARCHAR (15)  NOT NULL,
    [Beschrijving]             NVARCHAR (MAX) NULL,
    [SoftDeleted]              BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]               ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([EconomischeFunctieID] ASC),
    CONSTRAINT [FK_EconomischeFunctie_EconomischeFunctieType] FOREIGN KEY ([EconomischeFunctieTypeID]) REFERENCES [Verkennota].[EconomischeFunctieType] ([EconomischeFunctieTypeID]),
    CONSTRAINT [FK_EconomischeFunctie_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID])
);

