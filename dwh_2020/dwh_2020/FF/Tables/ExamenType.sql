CREATE TABLE [FF].[ExamenType] (
    [ExamenTypeID]           NVARCHAR (15)   NOT NULL,
    [IndieningTypeID]        NVARCHAR (15)   NOT NULL,
    [Description]            NVARCHAR (50)   NOT NULL,
    [DependencySet]          NVARCHAR (200)  NULL,
    [SortOrder]              INT             NULL,
    [Jaartal]                INT             NOT NULL,
    [AantalVragen]           INT             NULL,
    [MinimumScorePercentage] DECIMAL (10, 2) NULL,
    [ExamenCodeID]           NVARCHAR (15)   NULL,
    [Comment]                NVARCHAR (800)  NULL,
    [Visible]                BIT             DEFAULT ((0)) NOT NULL,
    [SoftDeleted]            BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]             ROWVERSION      NOT NULL,
    CONSTRAINT [PK_ExamenType] PRIMARY KEY CLUSTERED ([ExamenTypeID] ASC),
    CONSTRAINT [FK_ExamenType_ExamenCode] FOREIGN KEY ([ExamenCodeID]) REFERENCES [FF].[ExamenCode] ([ExamenCodeID]),
    CONSTRAINT [FK_ExamenType_IndieningType] FOREIGN KEY ([IndieningTypeID]) REFERENCES [IR].[IndieningType] ([IndieningTypeID])
);

