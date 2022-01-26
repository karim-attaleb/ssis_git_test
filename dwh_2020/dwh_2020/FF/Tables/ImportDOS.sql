CREATE TABLE [FF].[ImportDOS] (
    [ImportDOSID]   INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]   INT           NOT NULL,
    [DossierNummer] NVARCHAR (15) NULL,
    [ActieCode]     NVARCHAR (15) NOT NULL,
    [Datum]         DATETIME      NOT NULL,
    [SoftDeleted]   BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]    ROWVERSION    NOT NULL,
    CONSTRAINT [PK_ImportDOS] PRIMARY KEY CLUSTERED ([ImportDOSID] ASC),
    CONSTRAINT [FK_ImportDOS_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

