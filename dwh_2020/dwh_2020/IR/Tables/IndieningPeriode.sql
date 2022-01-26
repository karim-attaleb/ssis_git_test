CREATE TABLE [IR].[IndieningPeriode] (
    [IndieningPeriodeID]     INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]            INT              NOT NULL,
    [IndieningPeriodeTypeID] NVARCHAR (15)    NOT NULL,
    [VanDatum]               DATETIME         NOT NULL,
    [TotDatum]               DATETIME         NULL,
    [SoftDeleted]            BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]             ROWVERSION       NOT NULL,
    [IndieningPeriodeGUID]   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_IndieningPeriode] PRIMARY KEY CLUSTERED ([IndieningPeriodeID] ASC),
    CONSTRAINT [FK_IndieningPeriode_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_IndieningPeriode_IndieningPeriodeType] FOREIGN KEY ([IndieningPeriodeTypeID]) REFERENCES [IR].[IndieningPeriodeType] ([IndieningPeriodeTypeID])
);

