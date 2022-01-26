CREATE TABLE [FF].[MeldingBestrijding] (
    [IndieningID]                   INT            NOT NULL,
    [VerwachteSchadeID]             NVARCHAR (15)  NULL,
    [VerwachteSchadeToelichting]    NVARCHAR (MAX) NULL,
    [DatumPeriodeVan]               DATETIME       NULL,
    [DatumPeriodeTot]               DATETIME       NULL,
    [BestrijdingsActieID]           NVARCHAR (MAX) NULL,
    [MeldingBestrijdingDatumTypeID] NVARCHAR (15)  NULL,
    [SoftDeleted]                   BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                    ROWVERSION     NOT NULL,
    CONSTRAINT [PK_MeldingBestrijding] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_MeldingBestrijding_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

