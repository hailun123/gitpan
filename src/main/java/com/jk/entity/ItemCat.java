package com.jk.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class ItemCat implements Serializable{
    private static final long serialVersionUID = 1362935337938305868L;
    private BigDecimal id;

    private BigDecimal parentId;

    private String name;

    private BigDecimal status;

    private BigDecimal sortOrder;

    private BigDecimal isParent;

    private Date created;

    private Date updated;
    private List children;
    private String states="closed";
    public String getStates() {
        return states;
    }

    public void setStates(String states) {
        this.states = states;
    }



    public List getChildren() {
        return children;
    }

    public void setChildren(List children) {
        this.children = children;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getParentId() {
        return parentId;
    }

    public void setParentId(BigDecimal parentId) {


        this.parentId = parentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public BigDecimal getStatus() {
        return status;
    }

    public void setStatus(BigDecimal status) {
        this.status = status;
    }

    public BigDecimal getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(BigDecimal sortOrder) {
        this.sortOrder = sortOrder;
    }

    public BigDecimal getIsParent() {
        return isParent;
    }

    public void setIsParent(BigDecimal isParent) {
        //  根据  父 ID 状态  给 状态 赋值
        //
        this.isParent = isParent;
        if (this.isParent.intValue() == 0) {
            this.states="open";
        }
    }


    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getUpdated() {
        return updated;
    }

    public void setUpdated(Date updated) {
        this.updated = updated;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ItemCat itemCat = (ItemCat) o;

        if (!id.equals(itemCat.id)) return false;
        if (!parentId.equals(itemCat.parentId)) return false;
        if (!name.equals(itemCat.name)) return false;
        if (!status.equals(itemCat.status)) return false;
        if (!sortOrder.equals(itemCat.sortOrder)) return false;
        if (!isParent.equals(itemCat.isParent)) return false;
        if (!created.equals(itemCat.created)) return false;
        return updated.equals(itemCat.updated);
    }

    @Override
    public int hashCode() {
        int result = id.hashCode();
        result = 31 * result + parentId.hashCode();
        result = 31 * result + name.hashCode();
        result = 31 * result + status.hashCode();
        result = 31 * result + sortOrder.hashCode();
        result = 31 * result + isParent.hashCode();
        result = 31 * result + created.hashCode();
        result = 31 * result + updated.hashCode();
        return result;
    }


}