CREATE TABLE [IR].[AttributeSetAttribute] (
    [AttributeSetAttributeID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AttributeSetID]          INT            NOT NULL,
    [AttributeID]             INT            NOT NULL,
    [SortOrder]               INT            NULL,
    [Recurrence]              INT            NULL,
    [Label]                   NVARCHAR (50)  NULL,
    [Tooltip]                 NVARCHAR (800) NULL,
    [Comment]                 NVARCHAR (800) NULL,
    [SoftDeleted]             BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]              ROWVERSION     NOT NULL,
    CONSTRAINT [PK_AttributeSetAttribute] PRIMARY KEY CLUSTERED ([AttributeSetAttributeID] ASC),
    CONSTRAINT [FK_AttributeSetAttribute_Attribute] FOREIGN KEY ([AttributeID]) REFERENCES [IR].[Attribute] ([AttributeID]),
    CONSTRAINT [FK_AttributeSetAttribute_AttributeSet] FOREIGN KEY ([AttributeSetID]) REFERENCES [IR].[AttributeSet] ([AttributeSetID])
);

