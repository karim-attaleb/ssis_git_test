CREATE TABLE [FF].[ExamenBlokType] (
    [ExamenBlokTypeID]       NVARCHAR (15)   NOT NULL,
    [ExamenTypeID]           NVARCHAR (15)   NOT NULL,
    [Description]            NVARCHAR (50)   NOT NULL,
    [DependencySet]          NVARCHAR (200)  NULL,
    [SortOrder]              INT             NULL,
    [MinimumScore]           DECIMAL (10, 2) NULL,
    [MaximumScore]           DECIMAL (10, 2) NULL,
    [MinimumScorePercentage] DECIMAL (10, 2) NULL,
    [Comment]                NVARCHAR (800)  NULL,
    [SoftDeleted]            BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]             ROWVERSION      NOT NULL,
    CONSTRAINT [PK_ExamenBlokType] PRIMARY KEY CLUSTERED ([ExamenBlokTypeID] ASC),
    CONSTRAINT [FK_ExamenBlokType_ExamenType] FOREIGN KEY ([ExamenTypeID]) REFERENCES [FF].[ExamenType] ([ExamenTypeID])
);

