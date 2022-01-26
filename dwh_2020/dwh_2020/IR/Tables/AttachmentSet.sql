CREATE TABLE [IR].[AttachmentSet] (
    [AttachmentSetID]   INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SoftDeleted]       BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]        ROWVERSION       NOT NULL,
    [AttachmentSetGUID] UNIQUEIDENTIFIER DEFAULT (newid()) NULL,
    CONSTRAINT [PK_AttachmentSet_AttachmentSetID] PRIMARY KEY CLUSTERED ([AttachmentSetID] ASC)
);

