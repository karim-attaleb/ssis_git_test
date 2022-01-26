CREATE TABLE [Verkennota].[EconomischGebruik] (
    [EconomischGebruikID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]             INT            NOT NULL,
    [EconomischGebruikTypeID] NVARCHAR (15)  NOT NULL,
    [Beschrijving]            NVARCHAR (MAX) NULL,
    [SoftDeleted]             BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]              ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([EconomischGebruikID] ASC),
    CONSTRAINT [FK_EconomischGebruik_EconomischGebruikType] FOREIGN KEY ([EconomischGebruikTypeID]) REFERENCES [Verkennota].[EconomischGebruikType] ([EconomischGebruikTypeID]),
    CONSTRAINT [FK_EconomischGebruik_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID])
);

