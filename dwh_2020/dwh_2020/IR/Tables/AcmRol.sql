CREATE TABLE [IR].[AcmRol] (
    [AcmRolID]      NVARCHAR (50)  NOT NULL,
    [Description]   NVARCHAR (50)  NOT NULL,
    [DependencySet] NVARCHAR (200) NULL,
    [SortOrder]     INT            NULL,
    [SoftDeleted]   BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]    ROWVERSION     NOT NULL,
    CONSTRAINT [PK_AcmRol] PRIMARY KEY CLUSTERED ([AcmRolID] ASC)
);

