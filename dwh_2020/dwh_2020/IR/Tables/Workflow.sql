CREATE TABLE [IR].[Workflow] (
    [WorkflowID]           INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [WorkflowTypeID]       NVARCHAR (15)  NOT NULL,
    [FromWorkflowStatusID] NVARCHAR (15)  NOT NULL,
    [ToWorkflowStatusID]   NVARCHAR (15)  NOT NULL,
    [WorkflowEventID]      NVARCHAR (15)  NOT NULL,
    [WorkflowConditionID]  NVARCHAR (15)  NULL,
    [WorkflowActionIDs]    NVARCHAR (200) NULL,
    [EvaluationOrder]      INT            DEFAULT ((0)) NULL,
    [TaskID]               NVARCHAR (15)  NULL,
    [PermissionID]         NVARCHAR (15)  NULL,
    [DependencySet]        NVARCHAR (200) NULL,
    [Comment]              NVARCHAR (800) NULL,
    [SoftDeleted]          BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION     NOT NULL,
    CONSTRAINT [PK_Workflow] PRIMARY KEY CLUSTERED ([WorkflowID] ASC),
    CONSTRAINT [FK_Workflow_WorkflowCondition] FOREIGN KEY ([WorkflowConditionID]) REFERENCES [IR].[WorkflowCondition] ([WorkflowConditionID]),
    CONSTRAINT [FK_Workflow_WorkflowEvent] FOREIGN KEY ([WorkflowEventID]) REFERENCES [IR].[WorkflowEvent] ([WorkflowEventID]),
    CONSTRAINT [FK_Workflow_WorkflowStatus_From] FOREIGN KEY ([FromWorkflowStatusID]) REFERENCES [IR].[WorkflowStatus] ([WorkflowStatusID]),
    CONSTRAINT [FK_Workflow_WorkflowStatus_To] FOREIGN KEY ([ToWorkflowStatusID]) REFERENCES [IR].[WorkflowStatus] ([WorkflowStatusID]),
    CONSTRAINT [FK_Workflow_WorkflowType] FOREIGN KEY ([WorkflowTypeID]) REFERENCES [IR].[WorkflowType] ([WorkflowTypeID]),
    CONSTRAINT [UK_Workflow] UNIQUE NONCLUSTERED ([WorkflowTypeID] ASC, [FromWorkflowStatusID] ASC, [ToWorkflowStatusID] ASC, [WorkflowEventID] ASC)
);

