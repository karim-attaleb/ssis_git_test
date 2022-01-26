CREATE TABLE [DOSIS].[DosisBron] (
    [DosisBronID]   NVARCHAR (15)  NOT NULL,
    [Description]   NVARCHAR (50)  NOT NULL,
    [Url]           NVARCHAR (255) NULL,
    [EMail]         NVARCHAR (255) NULL,
    [DependencySet] NVARCHAR (200) NULL,
    [SortOrder]     INT            NULL,
    [Comment]       NVARCHAR (800) NULL,
    [SoftDeleted]   BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]    ROWVERSION     NOT NULL,
    CONSTRAINT [PK_DosisBron] PRIMARY KEY CLUSTERED ([DosisBronID] ASC)
);

