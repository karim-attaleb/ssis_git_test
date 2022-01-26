CREATE TABLE [IR].[DynamicInfoSet] (
    [DynamicInfoSetID] INT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AttributeSetID]   INT        NOT NULL,
    [CreationDate]     DATETIME   NOT NULL,
    [SoftDeleted]      BIT        DEFAULT ((0)) NOT NULL,
    [RowVersion]       ROWVERSION NOT NULL,
    CONSTRAINT [PK_DynamicInfoSet] PRIMARY KEY CLUSTERED ([DynamicInfoSetID] ASC),
    CONSTRAINT [FK_DynamicInfoSet_AttributeSet] FOREIGN KEY ([AttributeSetID]) REFERENCES [IR].[AttributeSet] ([AttributeSetID])
);

