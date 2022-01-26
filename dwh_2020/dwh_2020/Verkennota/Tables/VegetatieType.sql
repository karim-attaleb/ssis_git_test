CREATE TABLE [Verkennota].[VegetatieType] (
    [VegetatieTypeID] NVARCHAR (15)  NOT NULL,
    [Description]     NVARCHAR (MAX) NOT NULL,
    [DependencySet]   NVARCHAR (200) NULL,
    [SortOrder]       INT            NULL,
    [Comment]         NVARCHAR (800) NULL,
    [SoftDeleted]     BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]      ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([VegetatieTypeID] ASC)
);

