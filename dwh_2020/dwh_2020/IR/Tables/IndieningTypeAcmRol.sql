CREATE TABLE [IR].[IndieningTypeAcmRol] (
    [IndieningTypeAcmRolID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningTypeID]       NVARCHAR (15)  NOT NULL,
    [AcmRolID]              NVARCHAR (50)  NOT NULL,
    [Description]           NVARCHAR (50)  NULL,
    [DependencySet]         NVARCHAR (200) NULL,
    [SortOrder]             INT            NULL,
    [Comment]               NVARCHAR (800) NULL,
    [SoftDeleted]           BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]            ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningTypeAcmRol] PRIMARY KEY CLUSTERED ([IndieningTypeAcmRolID] ASC),
    CONSTRAINT [FK_IndieningTypeAcmRol_AcmRol] FOREIGN KEY ([AcmRolID]) REFERENCES [IR].[AcmRol] ([AcmRolID]),
    CONSTRAINT [FK_IndieningTypeAcmRol_IndieningType] FOREIGN KEY ([IndieningTypeID]) REFERENCES [IR].[IndieningType] ([IndieningTypeID])
);

