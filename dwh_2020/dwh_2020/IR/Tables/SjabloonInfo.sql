CREATE TABLE [IR].[SjabloonInfo] (
    [SjabloonInfoID]          INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SjabloonInfoTypeID]      NVARCHAR (15)  NOT NULL,
    [SjabloonID]              INT            NULL,
    [Hyperlink]               NVARCHAR (200) NULL,
    [SjabloonTechnicalTypeID] NVARCHAR (15)  NULL,
    [SjabloonDocumentTypeID]  NVARCHAR (15)  NOT NULL,
    [DependencySet]           NVARCHAR (200) NULL,
    [VersionNumber]           INT            DEFAULT ((0)) NOT NULL,
    [BeginDate]               DATETIME       NOT NULL,
    [EndDate]                 DATETIME       NULL,
    [FileName]                NVARCHAR (200) NULL,
    [FileSize]                INT            NULL,
    [Description]             NVARCHAR (200) NULL,
    [Classification]          NVARCHAR (200) NULL,
    [Comment]                 NVARCHAR (800) NULL,
    [SortOrder]               INT            NULL,
    [SoftDeleted]             BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]              ROWVERSION     NOT NULL,
    CONSTRAINT [PK_SjabloonInfo_SjabloonInfoID] PRIMARY KEY CLUSTERED ([SjabloonInfoID] ASC),
    CONSTRAINT [FK_SjabloonInfo_Sjabloon] FOREIGN KEY ([SjabloonID]) REFERENCES [IR].[Sjabloon] ([SjabloonID]),
    CONSTRAINT [FK_SjabloonInfo_SjabloonDocumentType] FOREIGN KEY ([SjabloonDocumentTypeID]) REFERENCES [IR].[SjabloonDocumentType] ([SjabloonDocumentTypeID]),
    CONSTRAINT [FK_SjabloonInfo_SjabloonInfoType] FOREIGN KEY ([SjabloonInfoTypeID]) REFERENCES [IR].[SjabloonInfoType] ([SjabloonInfoTypeID]),
    CONSTRAINT [FK_SjabloonInfo_SjabloonTechnicalType] FOREIGN KEY ([SjabloonTechnicalTypeID]) REFERENCES [IR].[SjabloonTechnicalType] ([SjabloonTechnicalTypeID]),
    CONSTRAINT [UK_SjabloonInfo_SjabloonID] UNIQUE NONCLUSTERED ([SjabloonID] ASC, [Hyperlink] ASC)
);

