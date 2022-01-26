CREATE TABLE [IR].[AttributeSet] (
    [AttributeSetID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AttributeSetTypeID] NVARCHAR (15)  NOT NULL,
    [Description]        NVARCHAR (50)  NOT NULL,
    [Label]              NVARCHAR (50)  NULL,
    [DependencySet]      NVARCHAR (200) NULL,
    [VersionNumber]      INT            DEFAULT ((0)) NOT NULL,
    [BeginDate]          DATETIME       NOT NULL,
    [EndDate]            DATETIME       NULL,
    [Comment]            NVARCHAR (800) NULL,
    [SoftDeleted]        BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]         ROWVERSION     NOT NULL,
    CONSTRAINT [PK_AttributeSet] PRIMARY KEY CLUSTERED ([AttributeSetID] ASC),
    CONSTRAINT [FK_AttributeSet_AttributeSetType] FOREIGN KEY ([AttributeSetTypeID]) REFERENCES [IR].[AttributeSetType] ([AttributeSetTypeID])
);

