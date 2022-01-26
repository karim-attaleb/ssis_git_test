CREATE TABLE [IR].[AttachmentInfo] (
    [AttachmentInfoID]          INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AttachmentSetID]           INT              NOT NULL,
    [AttachmentID]              INT              NULL,
    [Hyperlink]                 NVARCHAR (2048)  NULL,
    [AttachmentTechnicalTypeID] NVARCHAR (15)    NULL,
    [AttachmentDocumentTypeID]  NVARCHAR (15)    NOT NULL,
    [FileName]                  NVARCHAR (200)   NULL,
    [FileSize]                  INT              NULL,
    [BeginDate]                 DATETIME         NULL,
    [EndDate]                   DATETIME         NULL,
    [Reference]                 NVARCHAR (50)    NULL,
    [Description]               NVARCHAR (200)   NULL,
    [Classification]            NVARCHAR (200)   NULL,
    [Comment]                   NVARCHAR (800)   NULL,
    [SoftDeleted]               BIT              CONSTRAINT [DF__tmp_ms_xx__SoftD__69D19EED] DEFAULT ((0)) NOT NULL,
    [RowVersion]                ROWVERSION       NOT NULL,
    [AttachmentInfoGUID]        UNIQUEIDENTIFIER CONSTRAINT [DF__Attachmen__Attac__1D472152] DEFAULT (newid()) NULL,
    [IsAvailableExternal]       BIT              NULL,
    [ExternalReference]         NVARCHAR (MAX)   NULL,
    [IsReadOnly]                BIT              CONSTRAINT [DF_AttachmentInfo_IsReadOnly] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_AttachmentInfo_AttachmentInfoID] PRIMARY KEY CLUSTERED ([AttachmentInfoID] ASC),
    CONSTRAINT [FK_AttachmentInfo_Attachment] FOREIGN KEY ([AttachmentID]) REFERENCES [IR].[Attachment] ([AttachmentID]),
    CONSTRAINT [FK_AttachmentInfo_AttachmentDocumentType] FOREIGN KEY ([AttachmentDocumentTypeID]) REFERENCES [IR].[AttachmentDocumentType] ([AttachmentDocumentTypeID]),
    CONSTRAINT [FK_AttachmentInfo_AttachmentSet_AttachmentSetID] FOREIGN KEY ([AttachmentSetID]) REFERENCES [IR].[AttachmentSet] ([AttachmentSetID]),
    CONSTRAINT [FK_AttachmentInfo_AttachmentTechnicalType] FOREIGN KEY ([AttachmentTechnicalTypeID]) REFERENCES [IR].[AttachmentTechnicalType] ([AttachmentTechnicalTypeID])
);


GO
CREATE NONCLUSTERED INDEX [ix_AttachmentSetID_IncludeAll]
    ON [IR].[AttachmentInfo]([AttachmentSetID] ASC)
    INCLUDE([AttachmentInfoID], [AttachmentID], [Hyperlink], [AttachmentTechnicalTypeID], [AttachmentDocumentTypeID], [FileName], [FileSize], [BeginDate], [EndDate], [Reference], [Description], [Classification], [Comment], [SoftDeleted], [RowVersion], [AttachmentInfoGUID], [IsAvailableExternal], [ExternalReference], [IsReadOnly])
    ON [Indexes];

