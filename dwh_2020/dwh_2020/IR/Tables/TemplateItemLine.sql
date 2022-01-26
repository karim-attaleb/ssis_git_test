CREATE TABLE [IR].[TemplateItemLine] (
    [TemplateItemLineID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TemplateItemID]     INT            NOT NULL,
    [Naam]               NVARCHAR (50)  NULL,
    [Beschrijving]       NVARCHAR (200) NULL,
    [SoftDeleted]        BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]         ROWVERSION     NOT NULL,
    CONSTRAINT [PK_TemplateItem_TemplateItemLineID] PRIMARY KEY CLUSTERED ([TemplateItemLineID] ASC),
    CONSTRAINT [FK_TemplateItem_TemplateItem] FOREIGN KEY ([TemplateItemID]) REFERENCES [IR].[TemplateItem] ([TemplateItemID])
);

