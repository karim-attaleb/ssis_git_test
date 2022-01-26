CREATE TABLE [IR].[Attribute] (
    [AttributeID]                 INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AttributeDataTypeID]         NVARCHAR (15)  NOT NULL,
    [AttributePresentationTypeID] NVARCHAR (15)  NOT NULL,
    [UnitID]                      NVARCHAR (15)  NULL,
    [Description]                 NVARCHAR (50)  NOT NULL,
    [Classification]              NVARCHAR (200) NULL,
    [Reference]                   NVARCHAR (50)  NULL,
    [Required]                    BIT            DEFAULT ((0)) NOT NULL,
    [SortOrder]                   INT            NULL,
    [Label]                       NVARCHAR (50)  NULL,
    [Tooltip]                     NVARCHAR (800) NULL,
    [DefaultValue]                NVARCHAR (200) NULL,
    [Comment]                     NVARCHAR (800) NULL,
    [SoftDeleted]                 BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                  ROWVERSION     NOT NULL,
    CONSTRAINT [PK_Attribute] PRIMARY KEY CLUSTERED ([AttributeID] ASC),
    CONSTRAINT [FK_Attribute_AttributeDataType] FOREIGN KEY ([AttributeDataTypeID]) REFERENCES [IR].[AttributeDataType] ([AttributeDataTypeID]),
    CONSTRAINT [FK_Attribute_AttributePresentationType] FOREIGN KEY ([AttributePresentationTypeID]) REFERENCES [IR].[AttributePresentationType] ([AttributePresentationTypeID]),
    CONSTRAINT [FK_Attribute_Unit] FOREIGN KEY ([UnitID]) REFERENCES [IR].[Unit] ([UnitID])
);

