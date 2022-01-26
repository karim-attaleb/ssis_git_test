CREATE TABLE [Verkennota].[ErkenningNatuurGebiedMotivatie] (
    [ErkenningNatuurGebiedMotivatieID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]                          INT            NOT NULL,
    [ErkenningNatuurGebiedMotivatieTypeID] NVARCHAR (15)  NOT NULL,
    [Beschrijving]                         NVARCHAR (MAX) NULL,
    [SoftDeleted]                          BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                           ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([ErkenningNatuurGebiedMotivatieID] ASC),
    CONSTRAINT [FK_ErkenningNatuurGebiedMotivatie_ErkenningNatuurGebiedMotivatieType] FOREIGN KEY ([ErkenningNatuurGebiedMotivatieTypeID]) REFERENCES [Verkennota].[ErkenningNatuurGebiedMotivatieType] ([ErkenningNatuurGebiedMotivatieTypeID]),
    CONSTRAINT [FK_ErkenningNatuurGebiedMotivatie_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID])
);

