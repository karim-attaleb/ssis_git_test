CREATE TABLE [IR].[UserCode] (
    [UserCodeID]            NVARCHAR (15)  NOT NULL,
    [UserCodeGroupID]       NVARCHAR (15)  NOT NULL,
    [ParentUserCodeID]      NVARCHAR (15)  NULL,
    [ParentUserCodeGroupID] NVARCHAR (15)  NULL,
    [Description]           NVARCHAR (MAX) NOT NULL,
    [DependencySet]         NVARCHAR (200) NULL,
    [SortOrder]             INT            NULL,
    [Comment]               NVARCHAR (800) NULL,
    [SoftDeleted]           BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]            ROWVERSION     NOT NULL,
    CONSTRAINT [PK_UserCode] PRIMARY KEY CLUSTERED ([UserCodeID] ASC, [UserCodeGroupID] ASC),
    CONSTRAINT [FK_UserCode_UserCode] FOREIGN KEY ([ParentUserCodeID], [ParentUserCodeGroupID]) REFERENCES [IR].[UserCode] ([UserCodeID], [UserCodeGroupID]),
    CONSTRAINT [FK_UserCode_UserCodeGroup] FOREIGN KEY ([UserCodeGroupID]) REFERENCES [IR].[UserCodeGroup] ([UserCodeGroupID])
);

