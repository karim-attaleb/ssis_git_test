CREATE TABLE [IR].[Attachment] (
    [AttachmentID]   INT             IDENTITY (1, 1) NOT NULL,
    [Content]        VARBINARY (MAX) NOT NULL,
    [UploadDateTime] DATETIME        NULL,
    [UploadUserName] NVARCHAR (100)  NULL,
    [SoftDeleted]    BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]     ROWVERSION      NOT NULL,
    CONSTRAINT [PK_Attachment_AttachmentID] PRIMARY KEY CLUSTERED ([AttachmentID] ASC)
) TEXTIMAGE_ON [DataBin];

