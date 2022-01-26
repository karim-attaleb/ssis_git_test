CREATE TABLE [DR].[Beslissing] (
    [BeslissingID]           INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]            INT             NOT NULL,
    [EindBeslissingID]       NVARCHAR (15)   NULL,
    [EindScoreInProcent]     DECIMAL (18, 2) NULL,
    [InterneMotivatie]       NVARCHAR (MAX)  NULL,
    [PubliekeMotivatie]      NVARCHAR (MAX)  NULL,
    [WeerhoudenKost]         DECIMAL (18, 2) NULL,
    [IsAkkoordOndertekenaar] BIT             NULL,
    [RedenAfwijkingAkkoord]  NVARCHAR (100)  NULL,
    [DatumBeslissing]        DATETIME        NULL,
    [BegindatumVergunning]   DATETIME        NULL,
    [EinddatumVergunning]    DATETIME        NULL,
    [SoftDeleted]            BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]             ROWVERSION      NOT NULL,
    CONSTRAINT [PK_BESLISSING] PRIMARY KEY CLUSTERED ([BeslissingID] ASC),
    CONSTRAINT [FK_Beslissing_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [DR].[Dossier] ([IndieningID])
);

