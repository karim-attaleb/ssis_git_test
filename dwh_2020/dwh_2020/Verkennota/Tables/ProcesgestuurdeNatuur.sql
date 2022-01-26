CREATE TABLE [Verkennota].[ProcesgestuurdeNatuur] (
    [ProcesgestuurdeNatuurID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]                 INT            NOT NULL,
    [ProcesgestuurdeNatuurTypeID] NVARCHAR (15)  NOT NULL,
    [Beschrijving]                NVARCHAR (MAX) NULL,
    [SoftDeleted]                 BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                  ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([ProcesgestuurdeNatuurID] ASC),
    CONSTRAINT [FK_ProcesgestuurdeNatuur_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID]),
    CONSTRAINT [FK_ProcesgestuurdeNatuur_ProcesgestuurdeNatuurType] FOREIGN KEY ([ProcesgestuurdeNatuurTypeID]) REFERENCES [Verkennota].[ProcesgestuurdeNatuurType] ([ProcesgestuurdeNatuurTypeID])
);

