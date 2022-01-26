CREATE TABLE [IR].[TemplateItem] (
    [TemplateItemID]       INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TemplateID]           INT             NOT NULL,
    [TemplateItemTypeID]   NVARCHAR (15)   NOT NULL,
    [TemplateItemStatusID] NVARCHAR (15)   NULL,
    [ReferentieNummer]     NVARCHAR (15)   NULL,
    [Naam]                 NVARCHAR (50)   NULL,
    [Beschrijving]         NVARCHAR (200)  NULL,
    [Commentaar]           NVARCHAR (800)  NULL,
    [BeginDatum]           DATETIME        NULL,
    [EindDatum]            DATETIME        NULL,
    [Bedrag]               DECIMAL (10, 2) NULL,
    [Confidentieel]        BIT             DEFAULT ((0)) NOT NULL,
    [SoftDeleted]          BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION      NOT NULL,
    CONSTRAINT [PK_TemplateItem_TemplateItemID] PRIMARY KEY CLUSTERED ([TemplateItemID] ASC),
    CONSTRAINT [FK_TemplateItem_Template] FOREIGN KEY ([TemplateID]) REFERENCES [IR].[Template] ([TemplateID]),
    CONSTRAINT [FK_TemplateItem_TemplateItemStatus] FOREIGN KEY ([TemplateItemStatusID]) REFERENCES [IR].[TemplateItemStatus] ([TemplateItemStatusID]),
    CONSTRAINT [FK_TemplateItem_TemplateItemType] FOREIGN KEY ([TemplateItemTypeID]) REFERENCES [IR].[TemplateItemType] ([TemplateItemTypeID])
);

