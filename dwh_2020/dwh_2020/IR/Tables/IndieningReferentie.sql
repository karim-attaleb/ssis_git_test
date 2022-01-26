CREATE TABLE [IR].[IndieningReferentie] (
    [IndieningReferentieID]     INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]               INT              NOT NULL,
    [IndieningReferentieTypeID] NVARCHAR (15)    NOT NULL,
    [Referentie]                NVARCHAR (MAX)   NULL,
    [SoftDeleted]               BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]                ROWVERSION       NOT NULL,
    [IndieningReferentieGUID]   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_IndieningReferentie] PRIMARY KEY CLUSTERED ([IndieningReferentieID] ASC),
    CONSTRAINT [FK_IndieningReferentie_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_IndieningReferentie_IndieningReferentieType] FOREIGN KEY ([IndieningReferentieTypeID]) REFERENCES [IR].[IndieningReferentieType] ([IndieningReferentieTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IXFK_DissierReferentie_Indiening]
    ON [IR].[IndieningReferentie]([IndieningID] ASC);


GO
CREATE NONCLUSTERED INDEX [IXFK_IndieningReferentie_IndieningReferentieType]
    ON [IR].[IndieningReferentie]([IndieningReferentieTypeID] ASC);

