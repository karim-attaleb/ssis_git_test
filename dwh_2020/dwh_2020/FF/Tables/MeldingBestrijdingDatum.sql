CREATE TABLE [FF].[MeldingBestrijdingDatum] (
    [MeldingBestrijdingDatumID] INT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]               INT        NOT NULL,
    [Datum]                     DATETIME   NOT NULL,
    [SoftDeleted]               BIT        DEFAULT ((0)) NOT NULL,
    [RowVersion]                ROWVERSION NOT NULL,
    CONSTRAINT [PK_MeldingBestrijdingDatum] PRIMARY KEY CLUSTERED ([MeldingBestrijdingDatumID] ASC),
    CONSTRAINT [FK_MeldingBestrijdingDatum_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_MeldingBestrijdingDatum_MeldingBestrijding] FOREIGN KEY ([IndieningID]) REFERENCES [FF].[MeldingBestrijding] ([IndieningID])
);

