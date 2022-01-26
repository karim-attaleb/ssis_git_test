CREATE TABLE [Verkennota].[EcologischeFunctie] (
    [EcologischeFunctieID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]              INT            NOT NULL,
    [EcologischeFunctieTypeID] NVARCHAR (15)  NOT NULL,
    [Beschrijving]             NVARCHAR (MAX) NULL,
    [SoftDeleted]              BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]               ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([EcologischeFunctieID] ASC),
    CONSTRAINT [FK_EcologischeFunctie_EcologischeFunctieType] FOREIGN KEY ([EcologischeFunctieTypeID]) REFERENCES [Verkennota].[EcologischeFunctieType] ([EcologischeFunctieTypeID]),
    CONSTRAINT [FK_EcologischeFunctie_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID])
);

