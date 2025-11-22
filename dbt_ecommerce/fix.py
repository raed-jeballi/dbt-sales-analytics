import pandas as pd
import csv

def fix_kaggle_reviews():
    input_file = 'data/olist_order_reviews_dataset.csv'
    output_file = 'data/olist_order_reviews_dataset_fixed.csv'
    
    print("Fixing Kaggle Brazilian Ecommerce reviews CSV...")
    
    # Read with pandas using flexible settings for this specific dataset
    df = pd.read_csv(input_file,
                    encoding='utf-8',
                    quoting=csv.QUOTE_ALL,  # Important: handle quotes properly
                    doublequote=True,
                    escapechar='\\',
                    na_values=['', 'NULL', 'null'],
                    keep_default_na=False)
    
    print(f"Original shape: {df.shape}")
    print(f"Columns: {list(df.columns)}")
    
    # Check for any remaining issues
    print(f"Null values per column:")
    print(df.isnull().sum())
    
    # Save with proper CSV formatting
    df.to_csv(output_file, 
              index=False, 
              quoting=csv.QUOTE_ALL,  # Quote all fields
              encoding='utf-8')
    
    print(f"Fixed file saved: {output_file}")
    print(f"Sample of fixed data:")
    print(df.head(2))
    
    return df

# Run the fix
df = fix_kaggle_reviews()