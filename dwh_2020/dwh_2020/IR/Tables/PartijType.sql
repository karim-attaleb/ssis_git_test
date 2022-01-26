CREATE TABLE [IR].[PartijType] (
    [PartijTypeID]  NVARCHAR (15)  NOT NULL,
    [Description]   NVARCHAR (255) NOT NULL,
    [DependencySet] NVARCHAR (200) NULL,
    [SortOrder]     INT            NULL,
    [Comment]       NVARCHAR (800) NULL,
    [SoftDeleted]   BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]    ROWVERSION     NOT NULL,
    CONSTRAINT [PK_PartijType] PRIMARY KEY CLUSTERED ([PartijTypeID] ASC)
);

