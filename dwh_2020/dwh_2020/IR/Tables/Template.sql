CREATE TABLE [IR].[Template] (
    [TemplateID]       INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TemplateCode]     NVARCHAR (15)   NOT NULL,
    [TemplateTypeID]   NVARCHAR (15)   NOT NULL,
    [TemplateStatusID] NVARCHAR (15)   NULL,
    [DynamicInfoSetID] INT             NULL,
    [AttachmentSetID]  INT             NULL,
    [LinkedTemplateID] INT             NULL,
    [ReferentieNummer] NVARCHAR (15)   NULL,
    [Naam]             NVARCHAR (50)   NULL,
    [Beschrijving]     NVARCHAR (200)  NULL,
    [Commentaar]       NVARCHAR (800)  NULL,
    [BeginDatum]       DATETIME        NOT NULL,
    [EindDatum]        DATETIME        NULL,
    [Bedrag]           DECIMAL (10, 2) NULL,
    [Confidentieel]    BIT             DEFAULT ((0)) NOT NULL,
    [SoftDeleted]      BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]       ROWVERSION      NOT NULL,
    CONSTRAINT [PK_Template] PRIMARY KEY CLUSTERED ([TemplateID] ASC),
    CONSTRAINT [FK_Template_AttachmentSet] FOREIGN KEY ([AttachmentSetID]) REFERENCES [IR].[AttachmentSet] ([AttachmentSetID]),
    CONSTRAINT [FK_Template_DynamicInfoSet] FOREIGN KEY ([DynamicInfoSetID]) REFERENCES [IR].[DynamicInfoSet] ([DynamicInfoSetID]),
    CONSTRAINT [FK_Template_Template] FOREIGN KEY ([LinkedTemplateID]) REFERENCES [IR].[Template] ([TemplateID]),
    CONSTRAINT [FK_Template_TemplateStatus] FOREIGN KEY ([TemplateStatusID]) REFERENCES [IR].[TemplateStatus] ([TemplateStatusID]),
    CONSTRAINT [FK_Template_TemplateType] FOREIGN KEY ([TemplateTypeID]) REFERENCES [IR].[TemplateType] ([TemplateTypeID]),
    CONSTRAINT [UK_Template] UNIQUE NONCLUSTERED ([TemplateCode] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Template]
    ON [IR].[Template]([TemplateCode] ASC)
    ON [Indexes];

