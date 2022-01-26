CREATE TABLE [IR].[UserCodeDependency] (
    [UserCodeDependencyID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [UserCodeGroupID]      NVARCHAR (15)  NOT NULL,
    [TypeID]               NVARCHAR (15)  NOT NULL,
    [UserCodeID]           NVARCHAR (15)  NOT NULL,
    [DependencySet]        NVARCHAR (300) NULL,
    [Comment]              NVARCHAR (800) NULL,
    [SoftDeleted]          BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION     NOT NULL,
    CONSTRAINT [PK_UserCodeDependency] PRIMARY KEY CLUSTERED ([UserCodeDependencyID] ASC)
);

