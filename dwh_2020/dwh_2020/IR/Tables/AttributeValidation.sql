CREATE TABLE [IR].[AttributeValidation] (
    [AttributeValidationID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AttributeValidationTypeID] NVARCHAR (15)  NOT NULL,
    [AttributeID]               INT            NOT NULL,
    [Value]                     NVARCHAR (200) NULL,
    [Comment]                   NVARCHAR (800) NULL,
    [SoftDeleted]               BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                ROWVERSION     NOT NULL,
    CONSTRAINT [PK_AttributeValidation] PRIMARY KEY CLUSTERED ([AttributeValidationID] ASC),
    CONSTRAINT [FK_AttributeValidation_Attribute] FOREIGN KEY ([AttributeID]) REFERENCES [IR].[Attribute] ([AttributeID]),
    CONSTRAINT [FK_AttributeValidation_AttributeValidationType] FOREIGN KEY ([AttributeValidationTypeID]) REFERENCES [IR].[AttributeValidationType] ([AttributeValidationTypeID])
);

