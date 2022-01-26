CREATE TABLE [IR].[Indiening] (
    [IndieningID]           INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningTypeVersieID] NVARCHAR (15)    NOT NULL,
    [IndieningStatusID]     NVARCHAR (15)    NOT NULL,
    [AttachmentSetID]       INT              NULL,
    [DynamicInfoSetID]      INT              NULL,
    [Jaartal]               INT              NULL,
    [ProvincieID]           NVARCHAR (15)    NULL,
    [DossierNummer]         NVARCHAR (200)   NULL,
    [ReferentieNummer]      NVARCHAR (200)   NULL,
    [Titel]                 NVARCHAR (200)   NULL,
    [CreateDatum]           DATETIME         NOT NULL,
    [UpdateDatum]           DATETIME         NOT NULL,
    [DeletedDatum]          DATETIME         NULL,
    [IngediendDatum]        DATETIME         NULL,
    [BeslissingDatum]       DATETIME         NULL,
    [VersieNummer]          SMALLINT         DEFAULT ((1)) NOT NULL,
    [SnapshotIndieningID]   INT              NULL,
    [VersieDatum]           DATETIME         NULL,
    [SnapshotDatum]         DATETIME         NULL,
    [BronID]                NVARCHAR (15)    NOT NULL,
    [SoftDeleted]           BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]            ROWVERSION       NOT NULL,
    [Beschrijving]          NVARCHAR (MAX)   NULL,
    [IndieningGUID]         UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Bedrag]                DECIMAL (18, 2)  NULL,
    CONSTRAINT [PK_Indiening] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_Indiening_AttachmentSet] FOREIGN KEY ([AttachmentSetID]) REFERENCES [IR].[AttachmentSet] ([AttachmentSetID]),
    CONSTRAINT [FK_Indiening_BronID] FOREIGN KEY ([BronID]) REFERENCES [IR].[Bron] ([BronID]),
    CONSTRAINT [FK_Indiening_DynamicInfoSet] FOREIGN KEY ([DynamicInfoSetID]) REFERENCES [IR].[DynamicInfoSet] ([DynamicInfoSetID]),
    CONSTRAINT [FK_Indiening_Indiening] FOREIGN KEY ([SnapshotIndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_Indiening_IndieningStatus] FOREIGN KEY ([IndieningStatusID]) REFERENCES [IR].[IndieningStatus] ([IndieningStatusID]),
    CONSTRAINT [FK_Indiening_IndieningTypeVersie] FOREIGN KEY ([IndieningTypeVersieID]) REFERENCES [IR].[IndieningTypeVersie] ([IndieningTypeVersieID])
);


GO
CREATE NONCLUSTERED INDEX [IX_Indiening_DossierNummer]
    ON [IR].[Indiening]([DossierNummer] ASC)
    ON [Indexes];


GO
CREATE NONCLUSTERED INDEX [IX_Indiening_IndieningID]
    ON [IR].[Indiening]([IndieningID] ASC)
    ON [Indexes];


GO
CREATE NONCLUSTERED INDEX [IX_Indiening_IndieningStatusID]
    ON [IR].[Indiening]([IndieningStatusID] ASC)
    ON [Indexes];


GO
CREATE NONCLUSTERED INDEX [IX_Indiening_IndieningTypeVersieID]
    ON [IR].[Indiening]([IndieningTypeVersieID] ASC)
    ON [Indexes];


GO
CREATE NONCLUSTERED INDEX [IX_Indiening_SnapshotIndieningID]
    ON [IR].[Indiening]([SnapshotIndieningID] ASC)
    INCLUDE([IndieningID], [IndieningStatusID])
    ON [Indexes];


GO
CREATE NONCLUSTERED INDEX [IXFK_Dossier_Bron]
    ON [IR].[Indiening]([BronID] ASC)
    ON [Indexes];


GO
EXECUTE sp_addextendedproperty @name = N'MS_doc', @value = N'Is NULL bij de huidige (actieve) versie en bevat bij vorige versies een IndieningId die verwijst naar de huidige versie.
', @level0type = N'SCHEMA', @level0name = N'IR', @level1type = N'TABLE', @level1name = N'Indiening', @level2type = N'COLUMN', @level2name = N'SnapshotIndieningID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Doc', @value = N'Bevat data over meldingen, indieningen etc die eventueel tot een dossier kunnen leiden.', @level0type = N'SCHEMA', @level0name = N'IR', @level1type = N'TABLE', @level1name = N'Indiening';

