CREATE TABLE [IR].[DynamicInfo] (
    [DynamicInfoID]    INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DynamicInfoSetID] INT            NOT NULL,
    [AttributeID]      INT            NOT NULL,
    [Value]            NVARCHAR (200) NULL,
    [SoftDeleted]      BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]       ROWVERSION     NOT NULL,
    CONSTRAINT [PK_DynamicInfo] PRIMARY KEY CLUSTERED ([DynamicInfoID] ASC),
    CONSTRAINT [FK_DynamicInfo_Attribute] FOREIGN KEY ([AttributeID]) REFERENCES [IR].[Attribute] ([AttributeID]),
    CONSTRAINT [FK_DynamicInfo_DynamicInfoSet] FOREIGN KEY ([DynamicInfoSetID]) REFERENCES [IR].[DynamicInfoSet] ([DynamicInfoSetID])
);

