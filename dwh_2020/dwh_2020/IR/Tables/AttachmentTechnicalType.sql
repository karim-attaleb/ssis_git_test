CREATE TABLE [IR].[AttachmentTechnicalType] (
    [AttachmentTechnicalTypeID] NVARCHAR (15)  NOT NULL,
    [Description]               NVARCHAR (50)  NULL,
    [DependencySet]             NVARCHAR (200) NULL,
    [SortOrder]                 INT            NULL,
    [Comment]                   NVARCHAR (800) NULL,
    [SoftDeleted]               BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                ROWVERSION     NOT NULL,
    CONSTRAINT [PK_AttachmentTechnicalType_AttachmentTechnicalTypeID] PRIMARY KEY CLUSTERED ([AttachmentTechnicalTypeID] ASC)
);

