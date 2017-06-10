using Models;
using System;
using System.Collections.Generic;
using System.Data;

namespace Controllers
{
    public class CartController
    {
        private double totalCart;

        public double TotalCart
        {
            get { return totalCart; }
            set { totalCart = value; }
        }

        public List<CartInfo> CartList = new List<CartInfo>();

        public void AddToCart(CartInfo info)
        {
            bool isExists = false;
            foreach (CartInfo item in CartList)
            {
                if (item.Id == info.Id)
                {
                    item.Quantity++;
                    isExists = true;
                    break;
                }
            }
            if (!isExists)
            {
                CartList.Add(info);
            }
        }

        public DataTable ShowCart()
        {
            DataTable data = new DataTable();

            data.Columns.Add("ID", typeof(int));
            data.Columns.Add("Name", typeof(string));
            data.Columns.Add("NameUrl", typeof(string));
            data.Columns.Add("Price", typeof(double));
            data.Columns.Add("Quantity", typeof(int));
            data.Columns.Add("Picture", typeof(string));
            data.Columns.Add("TotalPrice", typeof(double));

            TotalCart = 0;

            foreach (CartInfo item in CartList)
            {
                DataRow drInfo = ProductController.Instance.ProductShowCart(item.Id.ToString(), item.Quantity).Rows[0];

                DataRow dr = data.NewRow();

                dr["ID"] = drInfo["id"];
                dr["Name"] = drInfo["name"];
                dr["NameUrl"] = drInfo["name_url"];
                dr["Price"] = drInfo["priceMain"];
                dr["Quantity"] = item.Quantity;
                dr["Picture"] = drInfo["picture"];
                dr["TotalPrice"] = drInfo["totalPrice"];

                data.Rows.Add(dr);


                TotalCart += Convert.ToDouble(drInfo["totalPrice"]);
            }

            return data;
        }

        public void UpdateCart(CartInfo info)
        {
            foreach (CartInfo item in CartList)
            {
                if (item.Id == info.Id)
                {
                    item.Quantity = info.Quantity;
                    if (info.Quantity <= 0)
                    {
                        CartList.Remove(item);
                    }
                    return;
                }
            }
        }

        public void DeleteItem(string id)
        {
            foreach (CartInfo item in CartList)
            {
                if (item.Id == id)
                {
                    CartList.Remove(item);
                    if (CartList.Count <= 0)
                    {
                        CartList.Clear();
                    }
                    break;
                }
            }
        }

    }
}
