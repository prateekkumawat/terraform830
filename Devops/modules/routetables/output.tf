output "routetable_created" {
  value = { 
    for k,v in local.routetable_blocks : 
    k => { 
      arn                       = v.arn
      id                        = v.id
      owner_id                  = v.owner_id
      tags_all                  = v.tags_all
    }
  }
}