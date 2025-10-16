import React, { useState } from "react";
import { router, usePage } from "@inertiajs/react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import Swal from "sweetalert2";

// 🧩 Type definitions
interface Permission {
  id: number;
  name: string;
}

interface Role {
  id: number;
  name: string;
  permissions: Permission[];
}

interface PageProps {
  roles: Role[];
  permissions: Permission[];
}

export default function RoleManagement() {
  const { roles, permissions } = usePage<PageProps>().props;
  const [loading, setLoading] = useState(false);
  const [roleName, setRoleName] = useState("");
  const [permissionName, setPermissionName] = useState("");

  // ✅ Update permissions for a role
  const handlePermissionChange = (
    roleId: number,
    permissionName: string,
    checked: boolean
  ) => {
    const role = roles.find((r) => r.id === roleId);
    if (!role) return;

    const updatedPermissions = checked
      ? [...role.permissions.map((p) => p.name), permissionName]
      : role.permissions
          .map((p) => p.name)
          .filter((p) => p !== permissionName);

    setLoading(true);
    router.post(
      `/admin/roles/${roleId}/update`,
      { permissions: updatedPermissions },
      {
        onSuccess: () =>
          Swal.fire("Updated", "Permissions updated successfully!", "success"),
        onFinish: () => setLoading(false),
      }
    );
  };

  // ✅ Add new role
  const addRole = () => {
    if (!roleName.trim()) return;
    router.post(
      "/admin/roles",
      { name: roleName },
      {
        onSuccess: () => {
          Swal.fire("Success", "Role created!", "success");
          setRoleName("");
        },
      }
    );
  };

  // ✅ Delete role
  const deleteRole = (id: number) => {
    Swal.fire({
      title: "Are you sure?",
      text: "This will permanently delete the role.",
      icon: "warning",
      showCancelButton: true,
    }).then((r) => {
      if (r.isConfirmed) {
        router.delete(`/admin/roles/${id}`);
      }
    });
  };

  // ✅ Add new permission
  const addPermission = () => {
    if (!permissionName.trim()) return;
    router.post(
      "/admin/permissions",
      { name: permissionName },
      {
        onSuccess: () => {
          Swal.fire("Created", "Permission added!", "success");
          setPermissionName("");
        },
      }
    );
  };

  // ✅ Delete permission
  const deletePermission = (id: number) => {
    Swal.fire({
      title: "Delete permission?",
      text: "This will permanently remove the permission.",
      icon: "warning",
      showCancelButton: true,
    }).then((r) => {
      if (r.isConfirmed) {
        router.delete(`/admin/permissions/${id}`);
      }
    });
  };

  return (
    <div className="p-6 space-y-6">
      <h2 className="text-2xl font-bold mb-4">Role & Permission Management</h2>

      {/* Create New Role */}
      <Card>
        <CardContent className="p-4 space-y-3">
          <div className="flex items-center gap-2">
            <input
              type="text"
              className="border rounded px-3 py-2 w-full"
              placeholder="Enter new role name (e.g., Manager)"
              value={roleName}
              onChange={(e) => setRoleName(e.target.value)}
            />
            <Button onClick={addRole}>Add Role</Button>
          </div>
        </CardContent>
      </Card>

      {/* Create New Permission */}
      <Card>
        <CardContent className="p-4 space-y-3">
          <div className="flex items-center gap-2">
            <input
              type="text"
              className="border rounded px-3 py-2 w-full"
              placeholder="Enter new permission (e.g., view payments)"
              value={permissionName}
              onChange={(e) => setPermissionName(e.target.value)}
            />
            <Button onClick={addPermission}>Add Permission</Button>
          </div>
        </CardContent>
      </Card>

      {/* Roles & Permissions */}
      {roles.map((role) => (
        <Card key={role.id}>
          <CardContent className="p-4 space-y-4">
            <div className="flex justify-between items-center">
              <h3 className="font-semibold text-lg">{role.name}</h3>
              <Button
                variant="destructive"
                size="sm"
                onClick={() => deleteRole(role.id)}
              >
                Delete Role
              </Button>
            </div>

            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-2">
              {permissions.map((permission) => (
                <div
                  key={permission.id}
                  className="flex items-center space-x-2 border rounded-lg px-3 py-2"
                >
                  <input
                    type="checkbox"
                    checked={role.permissions.some(
                      (p) => p.name === permission.name
                    )}
                    onChange={(e) =>
                      handlePermissionChange(
                        role.id,
                        permission.name,
                        e.target.checked
                      )
                    }
                    disabled={loading}
                  />
                  <span className="text-sm">{permission.name}</span>
                  <Button
                    variant="outline"
                    size="xs"
                    className="ml-auto text-xs"
                    onClick={() => deletePermission(permission.id)}
                  >
                    🗑
                  </Button>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      ))}
    </div>
  );
}

